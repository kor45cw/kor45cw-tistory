#Swift로 자료구조, 알고리즘 공부하기 (4) - Linked List

##Linked List 정의
기본적으로 리스트 자료구조는 두가지로 구분할 수 있습니다.

> 순차 리스트 : 배열을 기반으로 구현된 리스트
> 
> 연결 리스트 : 메모리의 동적할당을 기반으로 구현된 리스트

그중에서 우리는 연결 리스트, 즉 Linked List를 살펴보려고 합니다.

Linked List의 정의는 다음과 같습니다

- 각 노드가 데이터와 포인터를 갖고 한 줄로 연결 되어 있는 방식으로 데이터를 저장하는 자료구조

Linked List의 종류는 다음과 같습니다

- Singly Linked List
- Doubly Linked List
- Circular Linked List

그 중 지금은 Singly Linked List를  알아보려고 합니다.

##Linked List의 특징
기본적인 리스트 자료구조의 공통적인 특징은 다음과 같습니다.

- 리스트 자료구조는 데이터를 나란히 저장합니다. 그리고 중복된 데이터의 저장을 막지 않습니다.

연결 리스트의 기본적인 원리

- 필요할때마다 구조체 변수를 하나씩 동적할당해서 이들을 연결한다


다음은 아래 구현된 소스에 대한 설명입니다.

- ListInsert : 해당 data가 들어있는 노드를 생성하고 서로 가리키도록 합니다.
- ListFirst : 원소가 있으면 true를 반환하고, 해당 data를 출력합니다.
- ListNext : 다음 원소가 있으면 true를 반환하고, 해당 data를 출력합니다.
- ListRemove : current 노드를 제거하고 앞뒤 노드를 연결해서 다시 연결리스트로 만듭니다.
- ListCount : List안의 원소의 갯수를 return합니다.

- 다음 코드는 struct의 extension을 사용해 개발하였습니다.
	- enum의 indirect 선언은 노드가 다음 노드를 갖고 있을 수 있도록 하기 위함입니다. (어떤 오브젝트가 자기 자신을 원소로 갖을 수 있도록 하기 위함)
	- mutating 선언은 구조체 안에 있는 변수를 함수 내에서 수정하기 위함입니다.
	- inout 선언은 input값이 함수내에서 변하게 되면 해당 변수는 변경된 값을 갖게 만들기 위함입니다 (like C언어의 pointer)

###swift로 구현된 Linked List는 다음과 같습니다. (Playground 에서 작성)

```swift
import UIKit

enum node {
    indirect case Node(id: Int?, next: node?)
}

struct linkedList {
    var numberOfData: Int
    var head: node
    var current: node
    var before: node
    
    init() {
        numberOfData = 0
        head = node.Node(id: nil, next: nil)
        current = node.Node(id: nil, next: nil)
        before = node.Node(id: nil, next: nil)
    }
}

extension linkedList {
    mutating func ListInsert(data: Int) {
        guard case let .Node(id, next) = self.head else {
            return
        }
        let newNode = node.Node(id: data, next: next)
        head = node.Node(id: id, next: newNode)
        numberOfData = numberOfData + 1
    }
    
    mutating func ListFirst(inout dataOut: Int) -> Bool {
        guard case let .Node(_, next) = self.head else {
            return false
        }
        
        if next == nil {
            return false
        }
        
        before = head
        
        guard case let .Node(data, next2) = next! else {
            return false
        }
        
        current = node.Node(id: data, next: next2)

        dataOut = data!
        
        return true
    }
    
    mutating func ListNext(inout dataOut: Int) -> Bool {
        guard case let .Node(_, next) = self.current else {
            return false
        }
        
        if next == nil {
            return false
        }
        
        before = current
        
        guard case let .Node(data2, next2) = next! else {
            return false
        }
        
        current = node.Node(id: data2, next: next2)
        dataOut = data2!
        
        return true
    }
    
    mutating func ListRemove() -> Int {
        guard case let .Node(data, next) = self.current else {
            return -1
        }
        
        let removeData = data!
        
        guard case let .Node(id, _) = self.before else {
            return -1
        }
        
        before = node.Node(id: id, next: next)

        current = before
        head = node.Node(id: nil, next: before)
        numberOfData = numberOfData - 1
        
        return removeData
    }
    
    func ListCount() -> Int {
        return numberOfData
    }

}


func main() {
    var list = linkedList()
    var data: Int = -1
    
    list.ListInsert(11)
    list.ListInsert(11)
    list.ListInsert(22)
    list.ListInsert(22)
    list.ListInsert(33)

    print("number of current data : \(list.ListCount())")
    
    if (list.ListFirst(&data)) {
        print("\(data) ")
        
        while (list.ListNext(&data)) {
            print("\(data) ")
        }
    }

    print("")
    
    if (list.ListFirst(&data)) {
        if (data == 22) {
            list.ListRemove()
        }
        
        while (list.ListNext(&data)) {
            if (data == 22) {
                list.ListRemove()
            }
        }
    }
    
    print("number of current data : \(list.ListCount())")
    
    if (list.ListFirst(&data)) {
        print("\(data) ")
        
        while (list.ListNext(&data)) {
            print("\(data) ")
        }
    }

}

main()
```

해당 소스는 [여기에서]("https://github.com/kor45cw/DataStructure/tree/master/Swift/LinkedList.playground") 확인할수 있습니다.
