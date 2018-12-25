# Circular Queue
- 고정 사이즈 자료구조
	- 두 개의 index를 갖고 있다. (head, tail)
- 큐가 가득차게 되면, head의 index가 0으로 되돌아간다.

- 구현
	- push()
	- pop()
	- peek()
	- clear()
	- isEmpty
	- isFull
	- count
	- capacity

	
### 구현	

```swift
public enum Operation {
    case ignore, overwrite
}

public struct CircularQueue<T> {
    private var data: [T]
    private var head: Int = 0, tail: Int = 0
    private var internalCount: Int = 0
    private let defaultCapacity = 100
    private var operation: Operation = .overwrite
    
    
    public init() {
        data = [T]()
        data.reserveCapacity(defaultCapacity)
    }
    
    public init(_ count: Int, operation: Operation = .overwrite) {
        var capacity = count
        if capacity < 1 {
            capacity = defaultCapacity
        }
        
        if (capacity & (~capacity + 1)) != capacity {
            var b = 1
            while(b < capacity) {
                b = b << 1
            }
            capacity = b
        }
        
        data = [T]()
        data.reserveCapacity(capacity)
        self.operation = operation
    }
    
    public mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount = internalCount - 1
        return el
    }
    
    public func peek() -> T? {
        guard !isEmpty else { return nil }
        return data[head]
    }
    
    public mutating func push(_ element: T) {
        if isFull {
            switch operation {
            case .ignore:
                return
            case .overwrite:
                pop()
            }
        }
        
        if data.endIndex < data.capacity {
            data.append(element)
        } else {
            data[tail] = element
        }
        
        tail = incrementPointer(pointer: tail)
        internalCount = internalCount + 1
    }
    
    public mutating func clear() {
        head = 0
        tail = 0
        internalCount = 0
        data.removeAll(keepingCapacity: true)
    }
    
    public var count: Int {
        return internalCount
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
        return count < 1
    }
    
    private func incrementPointer(pointer: Int) -> Int {
        return (pointer + 1) & (data.capacity - 1)
    }
    
    private func decrementPointer(pointer: Int) -> Int {
        return (pointer - 1) & (data.capacity - 1)
    }
    
    private func convertLogicalToRealIndex(logicalIndex: Int) -> Int {
        return (head + logicalIndex) & (data.capacity - 1)
    }
    
    private func check(_ index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
}
```

### Protocols

- Sequence

```swift
extension CircularQueue: ExpressibleByArrayLiteral {
    public init<S: Sequence>(_ elements: S, size: Int) where S.Iterator.Element == T {
        self.init(size)
        elements.forEach { push($0) }
    }
    
    public init(arrayLiteral elements: T...) {
        self.init(elements, size: elements.count)
    }
}

extension CircularQueue: Sequence {
    // Complexity: O(1)
    public func makeIterator() -> AnyIterator<T> {
        var newData = [T]()
        if count > 0 {
            newData = [T](repeating: data[head], count: count)
            if head > tail {
                let front = data.capacity - head
                newData[0..<front] = data[head..<data.capacity]
                if front < count  {
                    newData[front + 1..<newData.capacity] = data[0..<count - front]
                }
            } else {
                newData[0..<tail - head] = data[head..<tail]
            }
        }
        return AnyIterator(IndexingIterator(_elements: newData.lazy))
    }
}
```
