# Swift Sequence, Iterator Protocol

##Sequence protocol
- Array, Dictionary, Set과 같은 Collection 타입의 기반이 되는 protocol
- 값을 반복 할 수 있는 타입 (ex. `for loop`)


```swift
for element in some {
    do(with: element)
}
```

- Sequence protocol을 구현하면, (forEach, map, filter, flatMap, prefix 등) 다양한 함수를 사용 가능
- 순차 접근을 해야하는 작업이 필요한 경우 Sequence 위에 구현하는것이 좋다.

- Sequence 프로토콜

```swift
protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Itertator
}
```


###Iterators
- Sequence는 makeIterator() 함수를 통해 Iterator를 생성하여 Element에 대한 접근을 제공한다.
- Iterator는 Sequence의 값을 한 번에 하나씩 생성하고 Sequence가 순회 할 때 상태를 갱신한다.


```swift
protcol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}
```

- 위 코드에서 associatedtype으로 선언된 Element는 Iterator가 생성하는 값의 유형을 지정한다.

```swift
extension Sequence where Iterator.Element == Int { ... }
```

- 위와 같은 코드를 많이 사용하게 되는데 Sequence 확장에서 제네릭 타입 제약시 Iterator.Element가 사용되는 이유이다.

- Iterator는 순회시 절대로 reversed 되거나 reset되지 않는다. 
- next() 함수에서 nil이 반환되지 않는다면 무한 루프에 빠질 수 있다.


- 대부분의 Iterators은 Value Type이다. 
	- 따라서 복사본을 만들면 두 인스턴스는 독립적으로 동작한다.

- Value Type이 아닌 Iterator.
	- AnyIterator는 원래의 Iterator를 Reference Type의 obejct에 wrapping 한다


- Sequence를 만드는 방법에는 또 다른 방법이 존재한다.

- sequence(first:next:)
	- first 인자가 첫번째 요소인 시퀀스를 반환 
	- (후속 요소는 next 인수 클로저로 생성)
- sequence(state:next:)
	- state 인자(가변 상태 유지 가능)를 통해 유연한 시퀀스를 만들 수 있음 
	- (후속 요소는 next 인수 클로저로 생성)