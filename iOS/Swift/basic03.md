# Basic ch03

## 흐름 제어
- switch 
	- fallthrough: case에 break가 걸리지 않음
	- case 값 where Bool값: 값이면서 bool값을 만족할 때
- for in
	- 구문 이름표 기능

```swift
numbersLoop: for num in numbers {
    if num > 5 {
        continue numbersLoop
    }
}
```

## 함수
- 함수의 전달인자로 값을 전달할 때는 보통 값을 복사해서 전달
- 값이 아닌 참조를 전달하려면 입출력 매개변수를 사용: inout
  - 외부의 값에 어떤 영향을 줄지 모르기 때문에 함수형 프로그래밍 패러다임에서는 지양하는 패턴

```swift
func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}
referenceParameter(&numbers)
```

- 함수를 하나의 데이터 타입으로 나타내는 방법
  - \(매개변수 타입의 나열\) -&gt; 반환 타입
- 중첩함수

```swift
func forMove(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition+1
    }
    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition-1
    }

    return shouldGoLeft ? goLeft : goRight
}
```

- 종료되지 않는 함수 
  - return되지 않는 함수
  - 프로세스 동작은 끝났으나, 오류를 던진다든가 하는 일을 하고 프로세스를 종료함

```swift
func crash() -> Never {
    fatalError("Something Very bad happend")
}
```

- 반환값을 무시할 수 있는 함수
  - @discardableResult 라는 선언속성 사용
  - 컴파일러가 경고하지 않음

## 옵셔널
- 변수나 상수 등에 꼭 값이 있다는 것을 보장할 수 없다    

