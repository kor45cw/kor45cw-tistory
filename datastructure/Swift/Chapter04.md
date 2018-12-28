# Stack
- 후입선출 자료구조 (Last In First Out). 
- 배열과 비슷하지만 접근이 더 많이 제한되고, 컨트롤 된다.
- stack은 요소에 접근하는 방법을 엄격히 제어하는 interface를 구현한다.

- 구현
	- push() : 스택의 마지막에 요소를 추가
	- pop() : 스택의 가장 위에 있는 요소를 제거하고 반환한다.
	- peek() : 스택의 가장 위에 있는 요소를 반환하지만, 제거하지는 않는다.
- 일반적으로 작동을 돕기위해 구현되는 것들
	- count : 스택이 갖고 있는 요소의 갯수를 반환
	- isEmpty : 스택이 비어있는지 아닌지를 반환
	
### 구현

```swift
public struct Stack<T> {
    private var elements = [T]()
    
    public mutating func pop() -> T? {
        return self.elements.popLast()
    }
    public mutating func push(_ element: T) {
        self.elements.append(element)
    }
    public func peek() -> T? {
        return self.elements.last
    }
    public var isEmpty: Bool {
        return self.elements.isEmpty
    }
    public var count: Int {
        return self.elements.count
    }
}
```	


### Protocols
- CustomStringConvertible, CustomDebugStringConvertible protocol을 추가할 것입니다.
- 이것들은 값을 출력하고자 할 때 친근한 이름을 반환할 수 있게 해줍니다.

```swift
extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }
    
    public var debugDescription: String {
        return self.elements.debugDescription
    }
}
```

- 이번에는 Stack이 IteratorProtocol를 따르도록 할 것입니다.

```swift
public struct ArrayIterator<T>: IteratorProtocol {
    var currentElement: [T]
    init(elements: [T]) {
        self.currentElement = elements
    }
    
    mutating public func next() -> T? {
        if !self.currentElement.isEmpty {
            return self.currentElement.popLast()
        }
        return nil
    }
}

extension Stack: Sequence {
    public func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator<T>(elements: self.elements)
    }
    
    public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        self.elements = Array(s.reversed())
    }
}
```

- 반복 및 시퀀스 구현을 위해 많은 보일러 플레이트 코드를 작성하는 대신, Swift 표준 라이브러리에서 이미 수행한 작업을 활용할 수 있다.
	- AnyIterator<Element> : 추상 IteratorProtocol base 타입. 관련된 IteratorProtocol 유형으로 사용.
	- AnySequence<Base> : base와 동일한 요소를 갖는 시퀀스를 생성한다. lazy에 대한 호출 아래에 사용되면 LazySequence 유형을 반환함
	- IndexingIterator<Elements> : 임의의 collection용 iterator. 또한 custom 하게 자신의 iterator를 생성하지 않은 collection의 기본 iterator이기도 하다.

	