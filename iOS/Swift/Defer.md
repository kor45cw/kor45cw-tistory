# How “defer” operator in Swift actually works

Swift2에서 처음 소개된 `defer`는 많이 사용되는 operator가 아니므로, 무엇을 하는지 모를 가능성이 많다.

defer는 클로져안에 현재 스코프의 맨 끝에 실행되어야 하는 코드 일부를 넣어서 사용한다.
한 메소드에서 많은 return을 갖고 있고, 각각의 코드 앞에 동일한 코드를 복사하여 붙여넣지 않으려는 경우에 유용하다.
defer안에 들어가는 코드는 보통 정리 루틴이다. (리스소를 할당하거나 함수가 시작될때 리소스를 캡쳐하는)

예들 들어, 함수 내에서 로직을 실행 하기 전에, 스레드 세이프한 동작을 구현하고 NSLock 개체를 잠그는 경우 
defer { lock.unlock() } 을 추가하면, 교착상태나 메모리 누수를 방지할 수 있다.


이제 정확히 어디에서 실행 되는 것인지 자세히 알아보죠

## Example #1

```swift
var a = "Hello"

func b() -> String {
  defer { a.append(" world") }
  return a
}
```

- 위의 코드는 꽤나 간단하므로 아래의 코드와 같아 보인다.

```swift
func d() -> String {
  a.append(" world")
  return a
}
```

- 하지만 결과는 다르다

```swift
a = "Hello"
print(b())
a = "Hello"
print(d())

// Hello
// Hello world
```

- defer 선언 안에 있는 것은 return 이 되고 난 후에 실행되는것 처럼 보인다.
- 출력은 이 아이디어를 증명하는 것 처럼 보이지만, 몇가지 모순이 존재한다

> defer 문은 지연 명령문이 나타나는 범위를 벗어난 프로그램 제어를 전송하기 직전에 코드를 실행하는 데 사용됩니다.

중요한 것은 함수가 리턴되고 난 뒤에 어떤 작업이 수행되는 것은 기술적으로 불가능하다는 것입니다.
실제로 무슨일이 일어나고 있는지 알아보려면 Hopper Disassembler를 통해 결과를 확인하자.

```
xcrun swiftc your_source_code.swift -o output_file

```

호퍼는 전체 앱을 실행가능한 프로세서 명령어 목록으로 분해합니다.
더해서 가독성을 위해 C와 비슷한 의사코드를 생성합니다.

위에서 볼 수 있는 함수 b()는 다음과 같다

```
int _$S05test_A01bSSyF() {
    swift_beginAccess(_$S05test_A01aSSvp, &var_18, 0x20, 0x0);
    rcx = *_$S05test_A01aSSvp;
    swift_bridgeObjectRetain(rcx);
    swift_endAccess(&var_18);
    $defer #1 ();
    rax = rcx;
    return rax;
}

int _$S05test_A01bSSyF6$deferL_yyF() {
    var_40 = Swift.String_builtinStringLiteralutf8CodeUnitCountisASCII.init(" world", 0x6, 0x1);
    swift_beginAccess(_$S05test_A01aSSvp, &var_20, 0x21, 0x0, &var_20, 0x21);
    $SSS6appendyySSF(var_40, 0x1);
    swift_endAccess(&var_20);
    rax = swift_bridgeObjectRelease(var_40);
    return rax;
}
```

- 먼저 위의 첫번째 함수는 b()를 나타내고, 두번째 함수는 defer 연산자에게 전달되는 클로져입니다.
- 예상대로 return 문은 두 함수의 마지막 작업입니다.
- swift_beginAccess 및 swift_endAccess에 대한 호출은 전역 변수 a에 액세스한 결과입니다.
- 그 안에서 전해지는 모든 무작위 변수에 집중할 필요는 없다.

---

- 핵심 라인은 3, 6, 7 이다.
- 3에서의 초기값은 rcx 레지스터에 저장된다.
- 그리고, defer하는 것을 6번째 줄로 부른다.
- b()의 경우, 새로운 문자열 "world"가 생성되어 문자열 a와 연결되는 것이다. (defer가 어떤것을 rax에 넣고 그것을 반환한다는 사실은 무시해라)
- 만환된 값이 이 레지스터에 저장되는 것은 관례일 뿐이다.
- 다시 첫번째 함수로 이동하자.
- defer 작업이 완료되면 이전에 저장한 값이 7번 라인의 rcx에서 rax로 이동되고 다음 단계에서 반환된다.

---

- 간단히, 이 트릭은 defer가 호출되고 side effect를 적용하기전에 원래의 값을 저장하는 것이다.
- 따라서 b()의 실제 등가는 다음과 같을 수 있다.

```swift
func c() -> String {
  let d = a
  a.append(" world")
  return d
}
```

- 별 차이가 없어 보인다.
- 어떤 차이가 나는지 알기 위해서 할당 작업에서 변수가 어떻게 작동하는 지를 구체적으로 볼 필요가 있다.
- Swift에는 value와 reference 타입의 데이터가 존재한다.
	- 참조타입을 사용하고자 한다면, 함수안에서 변형을 하게 되면 어떤식으로든 최신의 수정본이 반환될 것이다.

- 하지만 String은 value 타입으로, 각 할당이 그것의 새로운 복사본을 생성한 다는 것을 의미한다.
	- 그렇지만 문자열 자체는 텍스트의 벽이 아무리 트더라도 16바이트의 일정한 크기의 포장지에 불과하다.
- 그러나 실제 텍스트를 포함하는 기본문자버퍼는 reference 타입이며, 작업을 할당하는 동안 메모리 공간을 절약하기 위해 Copy-on-write를 유지한다.
	- 따라서 a에 값을 읽는다고 선언하는 문자열 변수의 수에 관계없이 실제 복사는 a.append(" world") 가 호출될 때 한번만 발생한다.
- 이론상으로는 문자열이 구현하는 Copy-on-write 의미론 덕분에 추가 변수에 대한 부담은 없다.
- Defer의 내용을 b() 안으로 추가하게 되면, b(), c()가 거의 동일하다는 것을 알 수 있다.

```
int _$S05test_A01bSSyF() {
    swift_beginAccess(_$S05test_A01aSSvp, &var_18, 0x20, 0x0);
    rcx = *_$S05test_A01aSSvp;
    swift_bridgeObjectRetain(rcx);
    swift_endAccess(&var_18);
    var_40 = Swift.String_builtinStringLiteralutf8CodeUnitCountisASCII.init(" world", 0x6, 0x1);
    swift_beginAccess(_$S05test_A01aSSvp, &var_20, 0x21, 0x0, &var_20, 0x21);
    $SSS6appendyySSF(var_40, 0x1);
    swift_endAccess(&var_20);
    swift_bridgeObjectRelease(var_40);
    rax = rcx;
    return rax;
}

int _$S05test_A01cSSyF() {
    swift_beginAccess(_$S05test_A01aSSvp, &var_20, 0x20, 0x0, &var_20);
    rax = *_$S05test_A01aSSvp;
    swift_bridgeObjectRetain(rax);
    swift_endAccess(&var_20);
    var_80 = Swift.String_builtinStringLiteralutf8CodeUnitCountisASCII.init(" world", 0x6, 0x1);
    swift_beginAccess(_$S05test_A01aSSvp, &var_38, 0x21, 0x0);
    $SSS6appendyySSF(var_80, 0x1);
    swift_endAccess(&var_38);
    swift_bridgeObjectRelease(var_80);
    rax = rax;
    return rax;
}
```


## Example #2


```swift
var a: String? = nil

func b() -> String {
    a = "Hello world"
    defer { a = nil }
    return a!
}

print(b())
```

- 현재 scope를 떠나기 전에 캡쳐된 자원을 처분하는 방식은 defer의 일반적인 사용사례와 유사하다.
- 우리는 함수내에 필연적으로 a = nil 이 발생한다는 것을 위에서 증명했다
- 그렇다면 왜 force unwrapping이 크래시를 일으키지 않는 것인지 Hopper를 통해 어떤 모습인지 살펴보자


```
int _$S10test_force1bSSyF() {
    var_40 = Swift.String_builtinStringLiteralutf8CodeUnitCountisASCII.init("Hello world", 0xb, 0x1);
    swift_beginAccess(_$S10test_force1aSSSgvp, &var_18, 0x21, 0x0, 0x21);
    rdi = *_$S10test_force1aSSSgvp;
    rsi = *qword_100001078;
    *_$S10test_force1aSSSgvp = var_40;
    *qword_100001078 = 0x1;
    _$SSSSgWOe(rdi, rsi);
    swift_endAccess(&var_18);
    swift_beginAccess(_$S10test_force1aSSSgvp, &var_30, 0x20, 0x0);
    rax = *_$S10test_force1aSSSgvp;
    rcx = *qword_100001078;
    var_48 = rax;
    var_50 = rcx;
    _$SSSSgWOy(rax, rcx);
    swift_endAccess(&var_30);
    if (var_48 != 0x0) {
            var_58 = var_48;
            var_60 = var_50;
            $defer #1 ();
            rax = var_58;
    }
    else {
            stack[-168] = "test_force.swift";
            *(int32_t *)(&stack[-168] + 0x20) = 0x1;
            *(&stack[-168] + 0x18) = 0x6;
            *(int32_t *)(&stack[-168] + 0x10) = 0x2;
            *(&stack[-168] + 0x8) = 0x10;
            Swift_fatalErrorMessage first-element-marker  first-element-marker fileline.flags("Fatal error", 0xb, 0x2, "Unexpectedly found nil while unwrapping an Optional value", 0x39, 0x2);
            asm { ud2 };
            rax = loc_100000d90();
    }
    return rax;
}
```

- 3줄짜리 코드가 34줄의 코드로 변화했다.
- 모든 줄을 파악하려고 하지마라. 의미있는 덩어리로 그룹화 하면 된다
- 2~9 번째 출은 b()의 첫번째 행을 나타낸다. 여기서 "Hello world" 문자열을 a에 할당한다.
- defer를 콜하는 것은 20번째 라인입니다. 
	- 다른 모든 것은 겉으로 보기에는 사소한 작업 반환 a에 속한다는 것을 의미합니다.


1. a의 값을 읽고 로컬 범위에서 저장합니다. 이것은 10 번과 16 번 라인에서 swift_beginAccess / swift_endAccess의 두 번째 쌍 사이에서 발생합니다.

2. 이전 단계에서 받은 값을 unwrapping하기. 17행과 32행 사이의 if 문은 다음과 같다. 18 ~ 21 행은 값이 존재할 때 성공적인 결과를 나타내며 24 ~ 31 행은 포장 해제를 위해 nil을 통과할 때 발생하는 충돌 루틴을 사용합니다.

3. 드디어 진짜 return! 그것은 33번째 줄이다.

- a = nil 할당이 마지막으로 값을 읽은 후에 발생하기 때문에 앱이 충돌하지 않는 것은 분명하다.
- defer가 unwrapping을 하기 전에 나타나는 것이 아니라 unwrapping 루틴 중간에 나타나는 방법을 살펴보세요
	- 다른 방법의 구현에 주입된 지연 코드를 발견할 수 있다는 것은 꽤나 매혹적인 것이다.


### Conclusions
- 단순한 오퍼레이터에 있어서, defer는 스스로 limit으로 몰아가는 정말 좋은 일을 하고 있다.
- 이 방법의 진정한 힘은 Swift 반환문을 개별 로우 레벨 작동으로 "분할"할 수 있으며, 마지막 반환 프로세서 명령 (ret) 사이에 끼워 넣을 수 있다는 것이다.
- 이렇게 하면 "임시" 중간 변수를 추가할 필요 없이 보다 우아하고 자연스러운 코드를 만들 수 있다.