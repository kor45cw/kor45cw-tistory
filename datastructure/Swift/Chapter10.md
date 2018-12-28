# 합병 정렬 (Merge Sort)
- 삽입정렬 보다 실행시간이 짧은 분할/정복 알고리즘
- recursion을 사용하여 작동
	- 반복적으로 정렬되지 않는 목록을 두 부분으로 분할
- base case: list의 내용물이 비어있거나 하나인 경우
- merge function은 입력과 동일한 크기의 임시 배열을 사용하기 때문에 O(n)의 공간을 차지


## 작동방법
- Divide
	- collection S가 없거나 하나인 경우: 이미 정렬되었으므로 return
	- 그렇지 않은 경우: collection을 S1과 S2로 나눈다 (2/N 개씩 순서대로)
- Conquer
	- 반복적으로 반씩 분류하여 충분히 작으면 base case로 해결
- Combine 
	- S1과 S2를 정렬된 순서로 병합한 후에 요소를 반환한다.


## Algorithm for array-based

```swift
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
```	

## Algorithm for linked list-based

```swift
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
```

## Performance 비교
- Playground performance : Array > Linked List
- Compiled code performance: Linked List > Array

