# Functional Programming 01

- Wikipedia
	- 자료 처리를 수학적 함수의 계산으로 취급하고 상태와 가변 데이터를 멀리하는 프로그래밍 패러다임
	- 출력값은 함수에 입력된 인수에만 의존하므로 항상 동일한 결과가 나오게 된다.

### Functional Programming 언어의 기본이 되는 3가지 Function

- Pure Function (순수함수)
	- side-effect가 없는 함수, 실행이 외부에 영향을 끼치지 않는 함수
	- thread에 안전하고 병렬적인 계산이 가능

- Anonymous Function (익명함수)	
	- 이름이 없는 함수
	- Swift의 closure 같은 것들이 해당

- Higher-order Function (고차함수)
	- 함수를 다루는 함수
	- 함수를 인자로 받거나 함수를 반환하는 함수

#### Swift에서 Pure Function

```swift
func plus10(value: Int) -> Int {
	return valute + 10
}
```	

#### Swift에서 Anonymous Function

```swift
let f = { (a: Int) in return a + 10 }
```

#### Swift에서 Higher-order Function

```swift
func run(completion: () -> Void) {
	completion()
}
```

- completion은 anonymous function
- run 이라는 함수가 익명함수를 인자로 받고 있으니 higher-order


## 자주 사용되는 다섯가지 higher-order function

#### forEach
- for in 과 같지만 중간에 종료는 불가능
- forEach는 for-in 과 달리 함수를 파라미터로 받음
- 콜렉션 안의 모든 구성요소를 전달받은 함수에 하나씩 넘겨서 함수를 실행시키는 역할을 한다고 생각하면 좋음


#### map
- 입력된 transform 함수를 이용해서 어떤 타입의 요소를 다른 타입으로 transform 해주는 역할을 한다.
- map은 꼭 collection에만 존재할 수 있는 것은 아니다.
- 어떤 타입이라도 transform을 지원할 수 있는 형태라면 map함수를 만들 수 있다.
- 그런 타입을 functor라고 한다.


#### filter
- 어떤 콜렉션에서 특정 조건에 맞는 element들을 filter링 하기 위해서 사용된다.
- Sequence protocol에 정의되어있다.


#### reduce
- collection의 element들을 이용해서 어떤 최종 결과 하나를 만들어 낼 때 사용


#### flatMap
- collection안의 collection을 flatten 시킨다
- collection안의 값들 중 Optional을 제거하는데 nil인 경우를 빼버린다.
	-  두가지 경우를 넓게 본다면, 각 element의 context를 제거한다는 동일한 동작을 하는 것으로 볼 수 있다.


## First Class Function (일급함수)

- High-ordered function을 포함하는 더 포괄적인 개념
- High-order의 경우 
	- 함수를 argument로 받을 수 있다
	- 함수를 return 할 수 있다
- First Class Function은 여기서 더 추가
	- anonymous function
	- nested function
	- non-local variable
	- closure
	- assigning functions to variables
	- equality

- Extensional Equality
	- 두 함수가 동일한 입력을 넣으면 동일한 결과를 return 하는 경우
- Intensional Equality
	- 두 함수가 동일한 로직을 가지는 경우
- Reference Equality
	- 모든 함수가 고유의 identifier를 가지며 그것으로 equality 유무를 확인


## Function Composition (함수 합성)
- 독립적인 여러개의 함수를 하나로 합치는 것

```swift
func compositor(f1: @escaping (Int) -> Int, f2: @escaping (Int) -> String) -> (Int) -> String {
	return { x in return f2(f1(x)) }
}

let composited = compositor(f1: increment, f2: message)
let result = composited(10)

print(result)
```	


## Currying
- 여러개의 파라미터를 받는 함수를 단일 파라미터를 갖는 함수들의 함수열로 바꾸는 것

```swift
func curry<X, Y, Z>(f: @escaping (X, Y) -> Z) -> (X) -> (Y) -> Z {
	return { x in { y in f(x,y) } }
}
```

- 가만히 생각해보면 두번째 파라미터의 활용을 지연해서 뒤에 결정할 수 있는 유연함을 제공한다

- 기존에 갖고 있던 사고의 틀을 꺠야 제대로 활용 가능한 부분이 있다.
