# Tree의 구현

## 이진트리 (Binary tree)

### Type and variations
- Full binary tree
	- 트리의 모든 노드 N에 대해, 0 또는 2개의 child node 가 존재하는 경우
- Perfect binary tree
	- 모든 내부 노드에는 2개의 child가 존재
	- 모든 leaf들은 같은 depth를 갖는다.
- Complete binary tree
	- 마지막 노드를 제외한 모든 레벨이 100% 채워진다. (기존 노드가 트리의 왼쪽에 항상 존재)
- Balanced binary tree
	- leaf 노드의 가능한 가장 작은 height를 갖는 트리


### Code
	
```swift
public class BinaryTreeNode<T: Comparable> {
    public var value: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    public weak var parent: BinaryTreeNode?
    
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }
    
    public init(value: T, left: BinaryTreeNode?, right: BinaryTreeNode?, parent: BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
}
```	

## Binary search trees
- 접근, 검색, 삽입, 삭제가 O(n) ~ O(logN)의 시간이 걸림
- 이 시간은 트리의 height에 따라 달라진다.

### 노드의 삽입
- 특성을 유지하기 위해서는 트리 위에서부터 다시 새로운 노드를 삽입하고, 삽입하려는 노드의 값에 따라 왼쪽 또는 오른쪽으로 내려가야한다.
- 사용자가 실수로 특성을 훼손하여 트리 중간에 새 노드를 삽입하지 않도록 하기 위해서 항상 이를 관리하는 `insertNodeFromRoot`를 호출한다.

```swift
public func inserNodeFromRoot(value: T) {
    guard self.parent == nil else { return }
    self.addNode(value: value)
}
    
private func addNode(value: T) {
    if value < self.value {
        if let leftChild = leftChild {
            leftChild.addNode(value: value)
        } else {
            let newNode = BinaryTreeNode(value: value)
            newNode.parent = self
            leftChild = newNode
        }
    } else {
        if let rightChild = rightChild {
            rightChild.addNode(value: value)
        } else {
            let newNode = BinaryTreeNode(value: value)
            newNode.parent = self
            rightChild = newNode
        }
    }
}
```

## Tree 순회 (traversals)

### Inorder tree walk
- First the left subtree -> then the node value -> then the right subtree

```swift
public class func traverseInOrder(node: BinaryTreeNode?) {
    guard let node = node else { return }
    
    BinaryTreeNode.traverseInOrder(node: node.leftChild)
    print(node.value)
    BinaryTreeNode.traverseInOrder(node: node.rightChild)
}
```

### Preorder tree walk

```swift
public class func traversePreOrder(node: BinaryTreeNode?) {
    guard let node = node else { return }
    
    print(node.value)
    BinaryTreeNode.traversePreOrder(node: node.leftChild)
    BinaryTreeNode.traversePreOrder(node: node.rightChild)
}
```

### Postorder tree walk

```swift
public class func traversePostOrder(node: BinaryTreeNode?) {
    guard let node = node else { return }
    
    BinaryTreeNode.traversePostOrder(node: node.leftChild)
    BinaryTreeNode.traversePostOrder(node: node.rightChild)
    print(node.value)
}
```


## Searching

```swift
public func search(value: T) -> BinaryTreeNode? {
    if value == self.value { return self }
    
    if value < self.value {
        guard let left = leftChild else { return nil }
        return left.search(value: value)
    } else {
        guard let right = rightChild else { return nil }
        return right.search(value: value)
    }
}
```

- completed tree에 대한 최악의 케이스에서 O(logN)의 시간
- O(n)는 선형이고, 여기서 n은 트리의 높이

## Deletion
- When x has both child
	- Find the smallest child that is greater than its value, which is going to be the minimum value of its right subtree. In the same way, we can also use the biggest child that is less than its value, which will be the maximum of its left subtree
	- Mode the position in the tree of the successor/predecessor to the position of the node to delete
	- Call the deletion process recursively in the successor/predecessor	

- x가 child가 1개인 경우
	- 우리는 부모노드로부터 노드 x에 대한 참조를 사용하여 노드 x의 자식노드를 가리킬 수 있다.

- x가 2개의 child를 갖는 경우
	- 오른쪽 하위 트리의 최소값이 될 값보다 큰 가장 작은 child를 찾으세요
	- 같은 방법으로 가장 큰 child를 찾으세요 (왼쪽 하위트리의 최대값보다 큰)
	- 선행/후행의 트리에 있는 위치를 삭제할 노드의 위치로 설정
	- 선행/후행에 대해서 재귀족으로 삭제 process를 요청	

```swift
public func delete() {
    if let left = leftChild {
        if let _ = rightChild {
            self.exchangeWithSuccessor()
        } else {
            self.connectParentTo(child: left)
        }
    } else if let right = rightChild {
        self.connectParentTo(child: right)
    } else {
        self.connectParentTo(child: nil)
    }
    self.parent = nil
    self.leftChild = nil
    self.rightChild = nil
}
    
private func exchangeWithSuccessor() {
    guard let right = self.rightChild, let left = self.leftChild else { return }
    
    let successor = right.miminum()
    successor.delete()
    successor.leftChild = left
    left.parent = successor
    
    if right !== successor {
        successor.rightChild = right
        right.parent = successor
    } else {
        successor.rightChild = nil
    }
    
    self.connectParentTo(child: successor)
}
    
private func connectParentTo(child: BinaryTreeNode?) {
    guard let parent = self.parent else {
        child?.parent = self.parent
        return
    }
    
    if parent.leftChild === self {
        parent.leftChild = child
        child?.parent = parent
    } else if parent.rightChild === self {
        parent.rightChild = child
        child?.parent = parent
    }
}
    
public func miminum() -> BinaryTreeNode {
    if let left = leftChild {
        return left.miminum()
    } else {
        return self
    }
}
```


## B-trees
- 두가지 차이점
	- 노드의 child 수가 2개로 제한되지않음
	- 노드의 key의 수 또한 1개가 아니다.

- self-balanced, rooted, sorted trees
	- logN 시간 안에 삽입,검색,삭제,접근 작업 허용

- 각 내부 노드에는 n개의 키가 있다
	- 내부 노드는 n+1개의 child node를 갖는다.

- B트리에 대한 X의 순서
	- 루트 노드는 1개의 값과 0~2개의 child를 갖을 수 있다
	- 다른 노드는 다음을 따른다
		- x/2 to x-1 개의 ordered key
		- (x/2)-1 to x 개의 child
	- 최악의 높이는 O(logN)
	- 모든 leaf의 depth는 동일

## Splay trees
- 트리에서 최근에 방문한 노드에 빠르게 접근할 수 있는 기능제공
- splay 작업을 수행하면 마지막에 접근한 노드가 트리의 새 root가 된다.
	- 최근에 방문한 노드는 항상 최소 높이를 갖기 때문에 다시 쉽고 빠르게 접근 가능
- 평균 높이는 O(logN)
- cache와 garbage collections에 사용

	
### Splay operation
- 노드를 루트로 이동시키는 3가지의 방법이 있다.
- 간단한 회전 또는 zig
	- X가 루트의 자식노드일때, 부모 P가 트리의 루트일 때 발생
	- 트리가 X에서 P로 edge에서 회전함
- Zig-Zig or Zag-Zag
	- P가 루트가 아니고 X와 P 모두 오른쪽 child거나 왼쪽 child 일때
	- 세개가 P에서 G까지 edge에서 회전한 다음 X에서 P까지 edge에서 회전
	- 오른쪽으로 2회 연속 회전하거나, 왼쪽으로 2회 연속 회전할때 우리는 zig-zig, zag-zag 회전을 갖는다.
- Zig-Zag
	- P가 루트가 아니고 X가 왼쪽 child 일때, 그리고 반대의 경우일 때 
	- 우선, 먼저 트리를 P와 X의 edge 중심으로 회전시키고, G과 X의 결과 가장자리 중심으로 회전 

	