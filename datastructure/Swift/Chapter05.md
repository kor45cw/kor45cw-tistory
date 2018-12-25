# Queue
- 선입선출 자료구조 (First In First Out)

- 구현
	- enqueue()
	- dequeue()
	- peek()
	- clear()
	- count
	- isEmpty
	- isFull
	
- 일반적으로 작동을 돕기위해 구현되는 것들
	- capacity : A read/write property for retrieving or setting the queue capacity
	- insert(at index: ) : a method that inserts an element at a specified index in the queue
	- remove(at index: ) : a method that removes an element at the specified index


### 구현
```swift
public struct Queue<T> {
    private var data = [T]()
    
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    public func peek() -> T? {
        return data.first
    }
    
    public mutating func enqueue(_ element: T) {
        data.append(element)
    }
    
    public mutating func clear() {
        data.removeAll()
    }
    
    public var count: Int {
        return data.count
    }
    
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    public var isFull: Bool {
        return count == data.capacity
    }
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
}
```	

- 배열은 capacity에 도달하면 동적으로 크기가 조정된다.


### Protocols

- Sequence

```swift
extension Queue: ExpressibleByArrayLiteral {
    public init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        data.append(contentsOf: elements)
    }
    
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}

extension Queue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: data.lazy))
    }
    public func generate() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: data.lazy))
    }
}
```

### MutableCollection protocol
- subscript를 사용해서 큐의 요소를 대입하고, 검색할 수 있게 해준다.

```swift
extension Queue: MutableCollection {
    private func check(index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count - 1
    }
    
    public func index(after i: Int) -> Int {
        return data.index(after: i)
    }
    
    public subscript(index: Int) -> T {
        get {
            check(index: index)
            return data[index]
        }
        set {
            check(index: index)
            data[index] = newValue
        }
    }
}
```
