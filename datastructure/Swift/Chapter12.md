# Tree
- 트리는 한 세트의 node로 구성된다.
	- 각 노드는 키값, 하위 노드의 집합 및 상위 노드에 대한 링크가 포함된 데이터 구조를 갖는다
- 부모가 없는 노드는 오직 하나: root of tree
- 트리 구조는 계층적 형태로 데이터를 나타낸다.
- 트리에는 제약 조건이 존재
	- 노드는 두번이상 참조될 수 없다.
	- 루트를 가리키는 노드는 없다.
	- 트리에는 cycle이 포함되지 않는다.

## 용어
- Root: 트리의 맨 위에 있는 노드, 유일한 부모가 없는 노드
- Node: value key를 갖고 하위 및 상위 노드에 대한 참조를 포함할 수 있는 자료구조.
- Edge: 상위 노드와 하위 노드 간의 연결을 나타낸다.
- Parent: 다른 노드에 연결되어 있고, 해당 노드 바로 위에 있는 노드를 parent라고 한다.
- Child: 다른 노드에 연결되어 있고, 해당 노드 바로 아래에 있는 노드를 child라고 한다.
- Sibling: 같은 부모를 같는 노드들을 일컫는다.
- Leaf: 더 이상 child가 없는 하위 노드
- Subtree: 주어진 노드의 모든 하위 목록
- Height of the node: 노드와 가장 멀리 연결된 leaf 사이의 edge 수
- Depth: 노드에서 루트까지의 edge 수 
- Level: depth + 1
- Tree traversal: 트리의 모든 노드를 한번씩 방문하는 과정

## Tree의 종류

### Binary Tree
- 가장 기본적인 유형의 tree
- 어떤 노드든 최대 두명의 child가 있는 경우

### Binary Search Tree
- 모든 단일 노드에 대해 다음 조건을 충족하는 binary tree
	- 노드 P가 있을 때
		- 왼쪽 하위 트리의 모든 노드 L에 대해: L.값 < P.값
		- 오른쪽 하위 트리의 모든 노드 R에 대해: P.값 <= R.값
	- 즉, 상위 노드의 왼쪽 하위 트리에 있는 모든 하위 노드의 경우, 하위 노드의 키값이 항상 상위 노드의 키값보다 작다.

### Balanced Binary Tree
- 좌우 균형이 맞는 이진트리
	- 좌우의 모양이 같다.

### B-tree
- balanced binary search tree와 유사하지만 1가지 다른점이 존재
	- B-tree는 노드당 2명 이상의 child를 가질 수 있다.

### Splay tree
- binary search tree의 특정 유형 (추가적인 이점을 제공)
	- 최근에 접근한 노드는 트리의 위쪽으로 이동한다.
	- 이 속성은 경우에 따라 최근 방문한 노드에 접근하는데 필요한 시간을 크게 단축한다.

### Red-black Tree
- self-balancing binary search tree (모든 노드가 color값을 추가적으로 갖는)
- 다음 색상의 조건을 만족해야한다.
	- 모든 노드는 색상이 있어야한다.
	- 루트는 black
	- 모든 null leaf 노드는 black
	- 빨간색 노드의 대해서는, 자식노드는 모두 black 이다
	- 각 노드의 경우, 노드에서부터 leaf까지의 모든 simple path는 동일한 수의 black node가 포함된다.
- 검색, 삽입, 삭제 등 주요 작업에 대해 최악의 경우를 보장해준다.

