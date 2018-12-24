# Iterators, Sequences, Collections


## Iterators
- Iterator는 IteratorProtocol을 따르는 타입을 말한다.
- collection에 대해 반복적으로 next() 메서드를 제공하여 sequence의 다음 요소를 반환하거나, 끝에 도달하면 nil을 제공하여 collection의 반복 상태를 캡슐화 하는 목적으로 사용

- protocol 은 다음과 같이 정의되어 있다.

```swift
public protocol IteratorProtocol {
	associatedtype Element
	public mutating func next() -> Self.Element?
}
```	

## Sequences
- Sequence는 Sequence protocol을 따른 모든 것을 말한다.
- Sequence를 IteratorProtocol에 기반한 콜렉션 타입을 포함한 Sequence 타입을 리턴하는 팩토리 반복자로 생각할 수 있다.

- protocol 은 다음과 같이 정의되어 있다.

```swift
public protocol Sequence {
	associatedtype Iterator : IteratorProtocol
	public func makeIterator() -> Self.Iterator
}
```

- associated type을 사용하면 프로토콜을 채택할 때 까지 하나 이상의 유형을 선언 할 수 있다. -> 이것이 우리가 제네릭을 구현하는 방법입니다.
- 이 정의를 사용하면 시퀀스 유형을 정의 할 때 실제 반복기 유형을 지정할 수 있습니다.
- 이 정의를 사용하면 sequence타입을 정의할 때 실제 iterator를 구현할 수 있다.
- makeIterator() : 일반적으로, 이 함수를 직접적으로 부를 일은 없습니다.
- for-in 문을 사용할 때 Swift는 런타임에 자동으로 이것을 호출합니다.


## Collections
- Collection는 Collection protocol을 따르는 모든 것을 말한다.
- 주소 지정가능한 위치와 함께 양방향 sequence를 제공한다.
	- 즉, Colletion에 대해 반복 할 때 요소의 index를 저장할 수 있으며, 나중에 다시 index를 통해서 접근할 수 있다.
- Collection protocol은 Sequence protocol 와 Indexable protocol를 따른다.
- 최소한의 제한조건
	- startIndex와 endIndex 속성
	- index(after: ) method: collection의 index를 앞으로 이동 시키는데 필요한 메소드
	- subscript: 적어도 요소에 대해 읽기전용 접근을 제공할 수 있는

	
