import UIKit

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


// MARK: Rotation
extension RedBlackTreeNode {
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
}

extension RedBlackTreeNode {
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

}
