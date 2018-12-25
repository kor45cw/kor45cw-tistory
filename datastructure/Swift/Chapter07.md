# Priority Queue
- 일반적인 큐와 비슷하다.
	- 각 요소에 우선순위가 할당 되어있는 점이 다르다.
- 우선순위가 낮은 요소가 먼저 디큐된다.

- 구현
	- push()
	- pop()
	- peek()
	- clear()
	- count
	- isEmpty

## 응용
- Best-first search algorithm
	- A* search algorithm 처럼 가중 그래프에서 두 노드 사이의 최단 경로를 찾는다.
- Prim algorithm
	- 가중치가 적용된 undirected 그래프에 대한 최소 신장 트리를 찾는다.

	
## 구현
```swift

public struct PriorityQueue<T: Comparable> {
    private var heap = [T]()
    private let ordered: (T, T) -> Bool
    public init(ascending: Bool = false, startingValues: [T] = []) {
        if ascending {
            ordered = { $0 > $1 }
        } else {
            ordered = { $0 < $1 }
        }
        
        heap = startingValues
        var i = (heap.count / 2) - 1
        while i >= 0 {
            sink(i)
            i = i - 1
        }
    }
    
    public var count: Int {
        return heap.count
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public mutating func push(_ element: T) {
        heap.append(element)
        swim(heap.count - 1)
    }
    
    public mutating func pop() -> T? {
        if heap.isEmpty { return nil }
        if heap.count == 1 { return heap.removeFirst() }
        
        heap.swapAt(0, heap.count - 1)
        let temp = heap.removeLast()
        sink(0)
        return temp
    }
    
    public mutating func remove(_ item: T) {
        if let index = heap.index(of: item) {
            heap.swapAt(index, heap.count - 1)
            heap.removeLast()
            swim(index)
            sink(index)
        }
    }
    
    public mutating func removeAll(_ item: T) {
        var lastCount = heap.count
        remove(item)
        while heap.count < lastCount {
            lastCount = heap.count
            remove(item)
        }
    }
    
    public func peek() -> T? {
        return heap.first
    }
    
    public mutating func clear() {
        heap.removeAll(keepingCapacity: false)
    }
    
    private mutating func sink(_ index: Int) {
        var index = index
        while 2 * index + 1 < heap.count {
            var j = 2 * index + 1
            if j < (heap.count - 1) && ordered(heap[j], heap[j+1]) { j = j + 1 }
            if !ordered(heap[index], heap[j]) { break }
            heap.swapAt(index, j)
            index = j
        }
    }
    
    private mutating func swim(_ index: Int) {
        var index = index
        while index > 0 && ordered(heap[(index-1)/2], heap[index]) {
            heap.swapAt((index-1)/2, index)
            index = (index-1)/2
        }
    }
}
```	

## Protocol
- PriorityQueue는 sequence, collection, IteratorProtocol를 따른다.

```swift
extension PriorityQueue: IteratorProtocol {
    public typealias Element = T
    public mutating func next() -> T? {
        return pop()
    }
}

extension PriorityQueue: Sequence {
    public typealias Iterator = PriorityQueue
    public func makeIterator() -> PriorityQueue<T> {
        return self
    }
}

extension PriorityQueue: Collection {
    public typealias Index = Int
    public var startIndex: Int { return heap.startIndex }
    public var endIndex: Int { return heap.endIndex }
    public subscript(i: Int) -> T { return heap[i] }
    public func index(after i: Int) -> Int {
        return heap.index(after: i)
    }
}
```