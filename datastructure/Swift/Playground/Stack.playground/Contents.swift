
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

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }
    
    public var debugDescription: String {
        return self.elements.debugDescription
    }
}

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

var stack = Stack<Int>()
stack.push(1)


for item in stack {
    print(item)
}
print(stack.debugDescription)
