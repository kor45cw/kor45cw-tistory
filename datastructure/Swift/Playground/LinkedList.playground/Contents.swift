private class Node<T> {
    var next: Node<T>?
    fileprivate var data: T
    init(data: T) {
        next = nil
        self.data = data
    }
}

public struct LinkedList<T> {
    private var head: Node<T>? = nil
    private var _count: Int = 0
    
    public mutating func push(_ element: T) {
        let node = Node<T>(data: element)
        node.next = head
        head = node
        _count = _count + 1
    }
    
    public mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        
        let item = head?.data
        head = head?.next
        _count = _count - 1
        return item
    }
    
    public func peek() -> T? {
        return head?.data
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return _count
    }
}

public struct NodeIterator<T>: IteratorProtocol {
    public typealias Element = T
    private var head: Node<Element>?
    fileprivate init(head: Node<T>?) {
        self.head = head
    }
    
    public mutating func next() -> T? {
        if head != nil {
            let item = head?.data
            self.head = head?.next
            return item
        }
        return nil
    }
}

extension LinkedList: Sequence {
    public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        for el in s {
            push(el)
        }
    }
    
    public typealias Iterator = NodeIterator<T>
    public func makeIterator() -> NodeIterator<T> {
        return NodeIterator<T>(head: head)
    }
}


var list = LinkedList<Int>()
list.push(1)
for item in list {
    print(item)
}
