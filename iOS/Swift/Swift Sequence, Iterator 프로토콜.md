# Swift Sequence, Iterator 프로토콜

##Sequence

- Sequence 프로토콜은 Array, Dictionary, Set과 같은 Collection 타입의 기반이 되는 프로토콜로, 값을 iterate(반복) 할 수 있는 동일한 타입의 일련의 값이다.
- Sequence를 순회하는 가장 일반적인 방법은 for loop를 통해서 사용 할 수 있다.

```swift
for element in someSequence {
    doSomething(with: element)
}
```

- Sequence 프로토콜을 구현하게되면 for loop를 통한 순회 뿐만아니라
- forEach, map, filter, flatMap, prefix 등등 다양하고 유용한 함수를 사용 할 수 있다.

- 즉, 일련의 값에 대한 순차적 접근에 의존하는 공통 작업을 해야한다면 Sequence 위에 구현하는 것을 고려해야한다.

- 특정 타입이 Sequence 프로토콜을 conform 하는 것은 간단하다. makeIterator() 함수만 구현해주면 된다.

- Sequence 프로토콜은 다음과 같이 선언되어 있다.

```swift
protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Itertator
}
```
Sequence에 대해서 잠시 접어두고 Iterator와 IteratorProtocol에 대해서 먼저 살펴보자.


###Iterators #
- Sequence는 makeIterator() 함수를 통해 iterator를 생성하여 Element에 대한 접근을 제공한다.
- Iterator는 Sequence의 값을 한 번에 하나씩 생성하고 Sequence가 순회 할 때 상태를 갱신한다.

- IteratorProtocol에 선언된 함수는 오직 next()뿐이다. next() 함수는 호출시 다음 Element를 반환하고, Sequence가 고갈되면 nil를 반환한다.

- IteratorProtocol 프로토콜은 다음과 같이 선언되어 있다.

```swift
protcol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}
```

- 위 코드에서 associatedtype으로 선언된 Element는 Iterator가 생성하는 값의 유형을 지정한다.

```swift
extension Sequence where Iterator.Element == CustomType { ... }
```
- 위와 같은 코드를 많이 사용하게 되는데 Sequence 확장에서 제네릭 타입 제약시 Iterator.Element가 사용되는 이유이다.

- Iterator를 직접적으로 순회하는 경우는 매우 드믈다. 왜냐하면 for loop으로 순회하는 것이 일반적이 방법이기 때문이다. (for loop도 내부에서는 다음과 같은 로직이 타고있다.)

```swift
var iterator = someSequence.makeIterator()
// next 함수에서 nil이 반환되기 전까지 계속 순회함
while let element = iterator.next() {
    doSometing(with: element)
}
```

- Iterator는 순회시 절대로 reversed 되거나 reset되지 않는다. next() 함수에서 nil이 반환되지 않는다면 무한 루프에 빠질 수 있다.

예제를 하나 살펴보자.

피보나치 수열을 IteratorProtocol을 conform하는 타입으로 만들 수 있다.

```swift
struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
```
- 위 코드의 next() 함수를 보면 튜플을 사용하여 첫번째 숫자를 반환하고 다음 호출을 위한 상태를 업데이트한다.
- 또한, nil을 반환하지 않기 때문에 무한 스트림을 생성하고 오버플로우가 날 때까지 순회시 프로그램이 죽는다.

따라서, 다음과 같이 코드를 수정하여 prefix 인덱스를 생성자로 받아 유한 스트림을 생성하는 Iterator로 바꿀 수 있다.

```swift
struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    var initial = 0
    let prefix: Int
    
    init(prefix: Int) {
        self.prefix = prefix
    }
    
    mutating func next() -> Int? {
        guard initial < prefix else {
            return nil
        }
        initial += 1
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
```

유한한 스트림을 생성하는 FibIterator 구조체를 만들었으니 다음과 같이 순회 할 수 있다.

```swift
var fibIterator = FibsIterator(prefix: 5)
while let value = fibIterator.next() {
    print(value)
}
// 0
// 1
// 1
// 2
// 3
```

###Conforming to Sequence #
- FibsIterator를 만들었기 때문에, FibsSequence도 쉽게 만들 수 있다.
- 위에서 언급한대로, makeIterator() 함수만 구현해주면 끝난다.

```swift
struct FibsSequence: Sequence {
    typealias Iterator = FibsIterator // 타입 추론으로 생략 할 수 있음
    let prefix: Int
    
    func makeIterator() -> FibsIterator {
        return FibsIterator(prefix: prefix)
    }
}
```

Sequence 프로토콜을 conform 하는 커스텀 타입을 만들었기 때문에 Sequence 프로토콜의 많은 기능을 사용 할 수 있다.

```swift
for value in fibsSequence {
    print(value) // 0, 1, 1, 2, 3
}
fibsSequence.map { $0 + 1 } // [1, 2, 2, 3, 4]
fibsSequence.filter { $0 % 2 == 0 } // [2]
fibsSequence.reduce(0, +) // 7
```


###Iterators and Value Semantics #
- 대부분의 Iterators은 값 타입이다. 따라서 복사본을 만들면 두 인스턴스는 독립적으로 동작한다.

- 예제를 위해 시스템 함수인 stride(from: to: by:) 로 살펴보자. (stride 함수는 Sequence를 반환한다.)

```swift
let seq = stride(from: 0, to: 10, by: 1)
var i1 = seq.makeIterator()
i1.next() // 0
i1.next() // 1

var i2 = i1

i1.next() // 2
i1.next() // 3
i2.next() // 2
i2.next() // 3
```

- 위 코드를 살펴보면 Iterator가 value semantic(값 타입) 인 것을 확인 할 수 있다.
- 하지만, 값 타입이 아닌 Iterator도 존재한다. 이를 살펴보자.

- AnyIterator는 다른 Iterator를 감싸는 Iterator인데, 원래의 Iterator의 구체적 유형?(concrete type) 을 지워버린다. (원래의 Iterator를 Reference(참조) 타입의 내부 object에 래핑함)

- AnyIterator는 public API를 구현할때 유용하게 사용될 수 있다. 즉, 구현 세부 사항을 드러내는 복잡한 iterator의 내용을 숨기려하는 경우다.

- AnyIterator가 값의 참조로 동작하는 예제를 살펴보자.

```swift
var i3 = AnyIterator(i1)
var i4 = i3

i3.next() // 4
i4.next() // 5
i3.next() // 6
i4.next() // 7
```

- 위의 stride 예제에 추가해보면, 원래의 Iterator(i1)이 AnyIterator로 감싸져 있고 구조체임에도 불구하고 원본과 복사본이 독립적이지 않는 것을 볼 수 있다.

- 자칫, 살펴보면 값 타입으로 동작하지 않고 참조되는 것은 버그를 발생 시킬 수 있지만, 크게 문제가 되는 것은 아니다.

- Itertaor는 일반적으로 코드에서 전달하는 것이 아니라, 한번 사용하여 Element를 반복하고 버리기 때문이다.

###Function-Based Iterators and Sequences #
- AnyIterator 구조체의 next() 함수의 구현 내용(클로져)을 인자로 취하는 생성자를 갖고 있다.
- 따라서 IteratorProtocol을 conform하는 새로운 타입을 만들지 않고 Itertaor를 생성 할 수 있다.

위의 피보나치 Iterator을 적용시켜보자.

```swift
func fibsIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    return AnyIterator {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
```

- 위 코드를 보면 state property를 클로저 내부에서 캡쳐링하여, 클로져가 호출 될 때 마다 state를 변경 시킬 수 있다.
- FibsIterator와 fibsIterator() 두개의 Iterator는 단 하나 기능상 차이점을 보인다.

- 위에서 살펴본 것 처럼 FibsIterator는 값 타입을 가지며, **fibsIterator()**는 참조 타입을 갖는다.

- 함수 형태로 Sequence를 생성하는 것은 더욱 더 간단하다.

```swift
func fibsSequence() -> AnySequence<Int> {
    return AnySequence(fibsIterator)
}
```

- Sequence를 만드는 방법에는 또 다른 방법이 존재한다.
- Swift3에서 나온 sequence함수를 사용하는 것이다.

sequence함수는 두가지 형태로 구성되어 있다.

- sequence(first:next:) > first 인자가 첫번째 요소인 시퀀스를 반환 (후속 요소는 next 인수 클로저로 생성)
- sequence(state:next:) > state 인자(가변 상태 유지 가능)를 통해 유연한 시퀀스를 만들 수 있음 (후속 요소는 next 인수 클로저로 생성)


sequence함수를 사용한 예제이다.

```swift
let randomNumbers = sequence(first: 100) { (previous: UInt32) in
    let newValue = arc4random_uniform(previous)
    guard newValue > 0 else {
        return nil
    }
    return newValue
}

Array(randomNumbers) // [100, 91, 36, 13, 2, 1]

let fibSequence = sequence(state: (0, 1)) { (state: inout(Int, Int)) -> Int? in
    let upcomingNumber = state.0
    state = (state.1, state.0 + state.1)
    return upcomingNumber
}

Array(fibSequence.prefix(5)) // [0, 1, 1, 2, 3]
```






###prefix(while:) #
while 클로저의 내용에 매칭되지 않는 요소가 나오기 전까지의 요소를 리턴

```swift
let ages = [12, 20, 15, 8, 16, 45, 33, 28, 38, 50]
let prefixed = ages.prefix { $0 < 40 }
print(prefixed)
```

- 위 코드를 실행해보면 결과는 [12, 20, 15, 8, 16] 이렇게 됩니다.
- 즉, while 클로저의 조건인 40보다 작은 요소가 나오기 전까지의 요소(12, 20, 15, 8, 16)를 반환합니다.

###drop(while:) #
while 클로저의 내용에 매칭되지 않는 요소가 나오기 전까지 요소를 삭제하고 나머지 요소를 반환

```swift
let ages = [12, 20, 15, 8, 16, 45, 33, 28, 38, 50]
let dropped = ages.drop { $0 < 40 }
print(dropped)
```

- 위 코드를 실행해보면 결과는 [45, 33, 28, 38, 50]이렇게 나옵니다.
- 즉, while 클로저의 조건 "40보다 작다" 에 매칭되는 12, 20, 15, 8, 16 를 삭제하고 45가 나오면 클로저 내용에 매칭되지 않기 때문에 나머지 요소가 반환됩니다. 45, 33, 28, 38, 50