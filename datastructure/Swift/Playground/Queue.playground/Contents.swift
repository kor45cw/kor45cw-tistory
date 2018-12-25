import UIKit

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


var queue = Queue<Int>()
queue.enqueue(1)

for item in queue {
    print(item)
}

queue[0] = 1
