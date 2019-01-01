# 함수형 Swift: 클로져 { }

> [출처](https://medium.com/swift-india/functional-swift-closures-67459b812d0)


- 클로져는 상수와 변수의 참조를 capture하고 저장할 수 있다.
	- 클로져가 이름 없이 어떤 값이든 capture 하는 함수라고 생각할 수 있다.
- 함수와 클로져는 swift에서 1급객체이다.
	- 저장, 전달, 다른 값이나 객체처럼 다뤄질 수 있다는 의미
	- completion handlers로 클로져를 전달하는 것은 많은 API에서 일반적인 패턴이다.
	- Standard Swift Library는 클로져를 대게 이벤트 핸들링과 콜백을 위해 사용한다.


## What’s Function?
- 함수는 특정한 작업을 수행하는 코드 뭉치이다.
- 함수의 이름을 부여하며, 이름은 함수를 호출하기 위해 사용된다.
- func 키워드로 함수를 정의하며
- 함수는 0개 이상의 매개변수와 0개 이상의 return 값을 갖을 수 있다.


## Function Types
- 함수 타입은 함수의 파라미터와 리턴타입으로 구성된다.
	- (Int, Int) -> Int
	- Int형을 반환하는 Int형 파라미터를 두개 갖고 있는 함수
- 함수는 아래와 같이 변수에 할당 가능하다.

```swift
var mathFunction: (Int, Int) -> Int = add
```

- 함수는 클로져의 특별한 경우다.
- 클로져는 다음 3가지 형태를 갖고 있다.
	- Global functions: 이름을 갖고 있고 value를 capture하지 않는다.
	- Nested functions: 이름을 갖고 value를 capture 할 수 있다.
	- Closure expressions: 이름을 갖고 있지 않으며 주변 context에서 값을 캡처할 수 있다.


## Closure Expression:

```swift
// Closure take no parameter and return nothing
let sayHello: () -> Void = {
    print("Hello")
}

sayHello()

// Closure take one parameter and return 1 parameter
let value: (Int) -> Int = { (value1) in
    return value1
}

print(value(5))

// Closure take two parameter and return 1 parameter
let add: (Int, Int) -> Int = { (value1, value2) in
    return value1 + value2
}

print(add(5, 4))

// Closure take two parameter and return String parameter
let addValues: (Int, Int) -> String = { (value1, value2) -> String in
    return String("Sum is: \(value1 + value2)")
}

print(addValues(5, 4))
```

##Shorthand Argument Names
- 클로져의 변수들은 위치로 표현될수 있다.
	- `$0`, `$1` 등등


##Implicit Returns from Closure:
- 단일 표현 클로져는 결과를 암묵적으로 return 키워드를 생략하여 반환할 수 있다.
- 다중 표현 클로져는 return 키워드를 생략할 수 없다.

```swift
let a: (Int) -> Int = { $0 * $0 }
```

## Trailing Closure:
- 함수의 마지막 인자로 긴 클로져 표현을 전달하게 되면 trailing closure로 사용 가능하다.
- trailing closure는 함수 호출의 () 뒤에 작성하게 된다.
- trailing closure 구문을 사용하는 경우 함수 호출에 대한 label을 작성하지 말아라.

```swift
func make(input: Int, completion: () -> Void) {
	completion()
}

make(input: 1) {
	print("A")
}

let digitsList = [1, 2, 3, 4, 5]

let sum = digitsList.reduce(0) { $0 + $1 }
print(sum)
// prints 15
```

- closure가 메서드에 대한 마지막 매개 변수인 경우 빠른 속도로 이렇게 쓸 수 있음 

##Capturing Values:
- 클로져는 그것이 정의된 주변 문맥으로부터 변수와 상수를 capture할 수 있다.
	- 상수와 변수를 정의한 원래 범위가 더이상 존재하지 않더라도 클로져는 내부에서 상수와 변수의 값을 참조하고 수정할 수 있다.
- 스위프트에서 값을 capture할 수 있는 가장 단순한 형태의 클로져는 다른 함수의 내부에 쓰여진 nested 함수이다.
- nested 함수는 외부 함수의 인수를 capture할 수 있으며 외부 함수 내에 정의된 상수 및 변수를 caputre 할 수 있다.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

- `makeIncrementer` 함수는 하나의 인자를 받아들입니다.
	- 입력은 Int형 이고 함수타입 () -> Int 를 반환합니다.
	- 이것은 단순히 값이 아니라 기능을 반환한다는 것을 의미한다.
	- 반환하는 함수에는 파라미터가 없으며 호출될 때마다 Int 값을 반환한다.
- nested function 인 incrementer에서 runningTotal의 값을 주변 문맥에서 capture 한다.

```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() // returns a value of 10
incrementByTem() // returns  a value of 20
```

```swift
//: Playground - Closures
import Foundation

class CaptureList: NSObject {
    let digit = 5
    
    override init() {
        super.init()
        
        makeSquareOfValue { [digit] squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: (Int) -> Void) {
        let squareDigit = digit * digit
        onCompletion(squareDigit)
    }
}

CaptureList()

```
> 참고: 스위프트는 최적화에 의해서 클로져가 만들어진 후에 mutated 되지 않는다면, 그리고 그 값이 클로져에 의해 mutated 되지 않는다면, 그 값 대신 값의 사본을 capture 하고 저장할 수 있다.
> 또한 스위프트는 더 이상 필요하지 않을 때 변수 처리에 관한 모든 메모리 관리를 다룬다.

- 함수 인수에서 긴 클로져를 제거하려면 typealias를 사용하십시오


```swift
//: Playground - Closures
import Foundation

class CaptureList: NSObject {
    let digit = 5
    typealias onCompletionHandler = (Int) -> Void
    
    override init() {
        super.init()
        
        makeSquareOfValue { [digit] squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: onCompletionHandler) {
        let squareDigit = digit * digit
        onCompletion(squareDigit)
    }
}

CaptureList()
```

## Non-escaping Closures:
- 클로져 파라미터들은 Swift3 이전에 default로 escaping 되었다.
- 클로져의 매개변수가 non-escaping으로 표현된 경우, 클로져가 function의 body를 빠져나오지 못한다.
- 함수의 인수로 클로져를 통과하면, 클로져는 함수의 body로 실행되며 컴파일러를 반환한다.(?)
- 실행이 종료되면, 통과된 클로져는 범위를 벗어나 더이상 memory에 존재하지 않게 된다.


## 최소한 알아야하는 것
> 클로져 매개변수는 기본적으로 non-escaping이다, 클로져 실행에서 벗어나려면 @escaping을 사용해야한다.

- 생명주기 of non-escaping closure
	1. 함수 호출 중에 함수의 인수로 클로져를 통과시킨다.
	2. 함수안의 작업을 하고 난 뒤에 클로져를 실행한다.
	3. function returns

- 더 나은 메모리 관리를 위해 스위프트는 모든 클로져를 기본적으로 non-escaping으로 변경했다. 위의 CaptureList는 non-escaping 클로져의 예시이다.

## Escaping Closures:
- 클로져는 클로져가 함수의 인수로 전달될 때 함수를 탈출하는 것으로 알려져 있지만, 함수가 return 된 후에 클로져가 호출된다.
- @escaping으로 클로져를 마킹 하는것은 클로져 내에서 명시적으로 자신을 언급해야한다는 것을 의미한다.

- @escaping 클로져의 수명 주기: 
	1. 함수 호출 중 함수 인수로 클로져를 통과시킨다. 
	2. 함수안에서 추가 작업을 수행하십시오. 
	3. 함수가 클로져를 비동기적 실행 또는 저장한다.
	4. 함수 반환.

- 기본적으로 클로져가 어디로 탈출(escaping)하는지 확인:
	- 함수타입의 변수는 암시적으로 탈출임
	- typealiases는 탈출을 암시함
	- Optional closures는 암시적으로 탈출할 수 있음

### Common Error:
non-escaping 클로져를 escaping 클로져로 할당되는 문제의 해결책은 두가지 방법이 있다.

- closure를 escaping으로 표시
- 클로져를 optional로 설정하여 @noescape 동작을 유지

- Mark closure as escaping
- Or keep the default @noescape behavior by making the closure optional

- 폐쇄를 탈출구로 표시
- 또는 폐쇄를 선택사항으로 설정하여 @noescape 기본 동작 유지


## Autoclosures:
- @autoclosure 속성은 클로져로 자동으로 wrapped되는 인수를 정의 할 수 있게 한다.
- 인자를 갖지 않고, 클로져가 호출될 때 감싸고 있던 값을 되돌려준다.
- `assert(condition:message:file:line:)` 함수는 autoclosure를 갖는다.
	- `condition`변수는 디버그에서만 eval 되며, condition이 false인 경우에 한하여 `message` 매개변수가 eval 된다.


```swift
func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {}
```

- `@autoclosure`는 `@escaping`와 함께 사용가능하다.

```swift
@autoclosure @escaping () -> Bool
```

##Closures vs Delegates:
- 해결책은 문제에 달려있다.
- 더욱이, 애플은 callback pattern 으로 초점을 맞추고 있다.
	- UIAlertAction은 이것의 한 예가 될것이다.


## Conclusion:
- 우리는 개념을 사용하지만 용어를 알지 못하는 경우가 많다.
- 나는 @escaping, @non-escaping, @autoclosure를 여러 번 사용했지만 실제 개념을 알지 못했다.
- 이 포스팅은 초보자와 숙련된 개발자들 모두에게 유용할 것이다.
