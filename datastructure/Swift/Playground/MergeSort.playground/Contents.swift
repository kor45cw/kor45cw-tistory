private class Node<T> {
    var next: Node<T>?
    fileprivate var data: T
    init(data: T) {
        next = nil
        self.data = data
    }
}

public struct LinkedList<T> {
    fileprivate var head: Node<T>? = nil
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

public func mergeSort<T: Comparable>(_ list: [T]) -> [T] {
    if list.count < 2 {
        return list
    }
    
    let center = list.count / 2
    return merge(mergeSort([T](list[0..<center])), rightHalf: mergeSort([T](list[center..<list.count])))
}

private func merge<T: Comparable>(_ leftHalf: [T], rightHalf: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var tempList = [T]()
    tempList.reserveCapacity(leftHalf.count + rightHalf.count)
    
    while leftIndex < leftHalf.count && rightIndex < rightHalf.count {
        if leftHalf[leftIndex] < rightHalf[rightIndex] {
            tempList.append(leftHalf[leftIndex])
            leftIndex = leftIndex + 1
        } else if leftHalf[leftIndex] > rightHalf[rightIndex] {
            tempList.append(rightHalf[rightIndex])
            rightIndex = rightIndex + 1
        } else {
            tempList.append(leftHalf[leftIndex])
            tempList.append(rightHalf[rightIndex])
            leftIndex = leftIndex + 1
            rightIndex = rightIndex + 1
        }
    }
    
    tempList += leftHalf[leftIndex..<leftHalf.count]
    tempList += rightHalf[rightIndex..<rightHalf.count]
    return tempList
}


func mergeSort<T: Comparable>(list: inout LinkedList<T>) {
    var left: Node<T>? = nil
    var right: Node<T>? = nil
    
    if list.head == nil || list.head?.next == nil {
        return
    }
    
    frontBackSplit(list: &list, front: &left, back: &right)
    
    var leftList = LinkedList<T>()
    leftList.head = left
    
    var rightList = LinkedList<T>()
    rightList.head = right
    
    mergeSort(list: &leftList)
    mergeSort(list: &rightList)
    
    list.head = merge(left: leftList.head, right: rightList.head)
}

private func merge<T: Comparable>(left: Node<T>?, right: Node<T>?) -> Node<T>? {
    var result: Node<T>? = nil
    if left == nil { return right }
    if right == nil { return left }
    
    if left!.data <= right!.data {
        result = left
        result?.next = merge(left: left?.next, right: right)
    } else {
        result = right
        result?.next = merge(left: left, right: right?.next)
    }
    
    return result
}

private func frontBackSplit<T: Comparable>(list: inout LinkedList<T>, front: inout Node<T>?, back: inout Node<T>?) {
    var fast: Node<T>?
    var slow: Node<T>?
    
    if list.head == nil || list.head?.next == nil {
        front = list.head
        back = nil
    } else {
        slow = list.head
        fast = list.head?.next
        
        while fast != nil {
            fast = fast?.next
            if fast != nil {
                slow = slow?.next
                fast = fast?.next
            }
        }
        
        front = list.head
        back = slow?.next
        slow?.next = nil
    }
}
