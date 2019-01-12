# Red-black trees
- 이진트리와 비슷하고 각 노드마다 color 값이 추가되었다.
- RB 트리는 다음의 컬러 조건을 만족해야한다.
	- 모든 노드는 red or black의 색상을 갖고 있어야한다.
	- 루트 노드는 black 이다
	- 모든 null leaf 노드는 black 이다
	- 어떤 red 노드에 대해서 그 child는 모두 black이다.
	- 각 노드에 대해서 모든 자손 노드에 대한 simple path는 같은 수의 black 노드를 갖는다.

- Search, Insertion, Deletion: O(logN)	
- Space: O(N)
- N: 트리의 노드 갯수

### 구현

```swift
public enum RedBlackTreeColor: Int {
    case red = 0
    case black = 1
}

public class RedBlackTreeNode<T: Comparable> {
    public var value: T
    public var leftChild: RedBlackTreeNode?
    public var rightChild: RedBlackTreeNode?
    public weak var parent: RedBlackTreeNode?
    
    public var color: RedBlackTreeColor
    
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil, color: .black)
    }
    
    public init(value: T, left: RedBlackTreeNode?, right: RedBlackTreeNode?, parent: RedBlackTreeNode?, color: RedBlackTreeColor) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
        self.color = color
    }
    
    var grandParentNode: RedBlackTreeNode? {
        return self.parent?.parent
    }
    
    var uncleNode: RedBlackTreeNode? {
        guard let grandParentNode = self.grandParentNode else { return nil }
        if parent === grandParentNode.leftChild {
            return grandParentNode.rightChild
        } else {
            return grandParentNode.leftChild
        }
    }
    
    public static func printTree(nodes: [RedBlackTreeNode]) {
        var children: [RedBlackTreeNode] = Array()
        
        for node in nodes {
            print("\(node.value) \(node.color)")
            if let leftChild = node.leftChild {
                children.append(leftChild)
            }
            if let rightChild = node.rightChild {
                children.append(rightChild)
            }
            
        }
        
        if children.count > 0 {
            printTree(nodes: children)
        }
    }
}
```

### Rotations

#### Right Rotation
- Step
	1. X 노드는 회전 후 새로운 트리의 root 노드가 된다. X의 상위였던 노드 Y는 이제 오른쪽 child 노드가 된다. (값이 더 크므로 오른쪽 하위 트리에 있어야 함)
	2. 만일 Y 노드가 부모노드를 갖고 있다면, 우리는 이제 그 부모를 X 노드에 할당한다.
	3. 노드 X의 오른쪽 child 노드는 이제 child 노드 Y의 왼쪽 child 노드이다.
	
#### Implementation

```swift
public func rotateRight() {
    guard let parent = parent else { return }
    
    let grandParent = parent.parent
    let newRightChildsLeftChild = self.rightChild
    var wasLeftChild = false
    if parent === grandParent?.leftChild {
        wasLeftChild = true
    }
    
    self.rightChild = parent
    self.rightChild?.parent = self
    
    self.parent = grandParent
    if wasLeftChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }
    
    self.rightChild?.leftChild = newRightChildsLeftChild
    self.rightChild?.leftChild?.parent = self.rightChild
}
```	


#### Left Rotation
- Step
	1. X 노드는 회전 후 새로운 트리의 왼쪽 child 노드가 된다. X의 오른쪽 child였던 노드 Y가 이제 parent 노드이다.(노드 Y 값이 더 크므로 노드 X가 노드 Y의 왼쪽 하위 트리에 있어야 함)
	2. 노드 X에 parent 항목이 있는 경우, 해당 parent 항목을 노드 Y에 할당
	3. Y노드의 왼쪽 child 노드는 이제 X노드의 오른쪽 child 노드가 되었다.	

	
#### Implementation
```swift
public func rotateLeft() {
    guard let parent = parent else { return }
    
    let grandParent = parent.parent
    let newLeftChildsRightChild = self.leftChild
    var wasLetfChild = false
    if parent === grandParent?.leftChild {
        wasLetfChild = true
    }
    
    self.leftChild = parent
    self.leftChild?.parent = self
    
    self.parent = grandParent
    if wasLetfChild {
        grandParent?.leftChild = self
    } else {
        grandParent?.rightChild = self
    }
    
    self.leftChild?.rightChild = newLeftChildsRightChild
    self.leftChild?.rightChild?.parent = self.leftChild
}
```	


### Insertion
- RB 트리의 경우 삽입과정이 까다롭다. 항상 5가지 색상의 조건을 유지해야하기 때문
- process
	- 이진검색트리에서 했던것과 같이 노드를 삽입한다. red를 기본색으로 설정하여
	- 첫번째 과정에서 1개 이상의 색상 규칙을 파괴했을 가능성이 있으므로, 트리의 색상 구조를 검토하고, 손상된 규칙을 수정한다.

#### Implementation
```swift
public func insertNodeFromRoot(value: T) {
    if let _ = self.parent {
        print("You can only add new nodes from the root node of the tree")
        return
    }
    self.addNode(value: value)
}
    
private func addNode(value: T) {
    if value < self.value {
        if let leftChild = leftChild {
            leftChild.addNode(value: value)
        } else {
            let newNode = RedBlackTreeNode(value: value)
            newNode.parent = self
            newNode.color = .red
            leftChild = newNode
            
            insertionReviewStep1(node: newNode)
        }
    } else {
        if let rightChild = rightChild {
            rightChild.addNode(value: value)
        } else {
            let newNode = RedBlackTreeNode(value: value)
            newNode.parent = self
            newNode.color = .red
            rightChild = newNode
            
            insertionReviewStep1(node: newNode)
        }
    }
}
    
private func insertionReviewStep1(node: RedBlackTreeNode) {
    if let _ = node.parent {
        insertionReviewStep2(node: node)
    } else {
        node.color = .black
    }
}
    
private func insertionReviewStep2(node: RedBlackTreeNode) {
    if node.parent?.color == .black {
        return
    }
    insertionReviewStep3(node: node)
}
    
private func insertionReviewStep3(node: RedBlackTreeNode) {
    if let uncle = node.uncleNode {
        if uncle.color == .red {
            node.parent?.color = .black
            uncle.color = .black
            if let grandParent = node.grandParentNode {
                grandParent.color = .red
                insertionReviewStep1(node: grandParent)
            }
            return
        }
    }
    insertionReviewStep4(node: node)
}
    
private func insertionReviewStep4(node: RedBlackTreeNode) {
    var node = node
    guard let grandParent = node.grandParentNode else { return }
    if node === node.parent?.rightChild && node.parent === grandParent.leftChild {
        node.parent?.rotateLeft()
        node = node.leftChild!
    } else if node === node.parent?.leftChild && node.parent === grandParent.rightChild {
        node.parent?.rotateRight()
        node = node.rightChild!
    }
    insertionReviewStep5(node: node)
}
    
private func insertionReviewStep5(node: RedBlackTreeNode) {
    guard let grandParent = node.grandParentNode else { return }
    
    node.parent?.color = .black
    grandParent.color = .red
    if node === node.parent?.leftChild {
        grandParent.rotateRight()
    } else {
        grandParent.rotateLeft()
    }
}
```	

1. Step1
	- 우리가 추가하는 노드는 트리의 첫번째 노드로, 루트이다. 
	- 루트 노드는 black 이어야 한다는 것을 알고 있기 때문에 그것을 추가한다.

2. Step2
	- 두번째 단계에서 parent노드가 빨간색인지, 검은색인지 확인하세요
	- 만약 검다면, 우리는 유효한 트리를 갖고 있다는 것입니다. (우리가 유효한 트리로 시작해서 red leaf를 추가한다는 것을 항상 상기하십시오)

3. Step3
	- 세번째 단계에서, 우리는 parent노드와 uncle 노드가 빨간색인지 확인할 것이다.
	- 빨간색이라면, 검은색으로 바꾸고, grandparent의 컬러도 빨간색으로 바꾼다.
		- 하지만 grandparent의 컬러를 빨간색으로 바꾼다면 두번째 색의 규칙(루트는 검은색)을 깰수 있다.
		- 이를 고치기 위해서, grandparent를 그대로 두고, 새로운 노드를 추가하여서, 1단계로부터 프로세스를 다시 호출 할 수 있다.

4. Step4
	- 4단계에 도달하면, parent는 빨간색이지만, uncle은 검은색일 가능성이 있다.
		- 우리는 노드 n이 P의 오른쪽 child 라고 가정할 것이다.
	- 회전 후 n과 P가 역할을 바꿨다. Node n은 P의 parent이다. 다음단계로 넘어가면, n과 P의 label을 교환할 것이다.

5. Step5
	- 마지막 단계에서는 노드 n과 부모 P가 모두 빨간색이고 부모의 자식의 방향과 반대로 회전