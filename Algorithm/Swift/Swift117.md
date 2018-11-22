# [Swift 문제풀이 117] 큐

[문제 링크](https://www.acmicpc.net/problem/10845)

## 문제

정수를 저장하는 큐를 구현한 다음, 입력으로 주어지는 명령을 처리하는 프로그램을 작성하시오.

명령은 총 여섯 가지이다.

- push X: 정수 X를 큐에 넣는 연산이다.
- pop: 큐에서 가장 앞에 있는 정수를 빼고, 그 수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.
- size: 큐에 들어있는 정수의 개수를 출력한다.
- empty: 큐가 비어있으면 1, 아니면 0을 출력한다.
- front: 큐의 가장 앞에 있는 정수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.
- back: 큐의 가장 뒤에 있는 정수를 출력한다. 만약 큐에 들어있는 정수가 없는 경우에는 -1을 출력한다.

## 풀이

```swift

import Foundation

let input = Int(readLine() ?? "") ?? 0
var stack: [Int] = []


func empty() -> Int {
    return stack.isEmpty ? 1 : 0
}

func front() -> Int {
    return stack.first ?? -1
}

func back() -> Int {
    return stack.last ?? -1
}

func size() -> Int {
    return stack.count
}

func pop() -> Int {
    return stack.isEmpty ? -1 : stack.removeFirst()
}

func push(_ input: Int) {
    stack.append(input)
}

for _ in 0..<input {
    let input = readLine() ?? ""

    switch input {
    case "pop":
        print(pop())
    case "size":
        print(size())
    case "empty":
        print(empty())
    case "front":
        print(front())
    case "back":
        print(back())
    case let x where x.contains("push"):
        let input = Int(x.replacingOccurrences(of: "push ", with: "")) ?? 0
        push(input)
    default:
        break
    }
}

```
