# [Swift 문제풀이 115] 스택

[문제 링크](https://www.acmicpc.net/problem/10828)

## 문제

정수를 저장하는 스택을 구현한 다음, 입력으로 주어지는 명령을 처리하는 프로그램을 작성하시오.

명령은 총 다섯 가지이다.

- push X: 정수 X를 스택에 넣는 연산이다.
- pop: 스택에서 가장 위에 있는 정수를 빼고, 그 수를 출력한다. 만약 스택에 들어있는 정수가 없는 경우에는 -1을 출력한다.
- size: 스택에 들어있는 정수의 개수를 출력한다.
- empty: 스택이 비어있으면 1, 아니면 0을 출력한다.
- top: 스택의 가장 위에 있는 정수를 출력한다. 만약 스택에 들어있는 정수가 없는 경우에는 -1을 출력한다.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var stack: [Int] = []


func empty() -> Int {
    return stack.isEmpty ? 1 : 0
}

func top() -> Int {
    return stack.first ?? -1
}

func size() -> Int {
    return stack.count
}

func pop() -> Int {
    return stack.isEmpty ? -1 : stack.removeFirst()
}

func push(_ input: Int) {
    stack.insert(input, at: 0)
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
    case "top":
        print(top())
    case let x where x.contains("push"):
        let input = Int(x.replacingOccurrences(of: "push ", with: "")) ?? 0
        push(input)
    default:
        break
    }
}
```
