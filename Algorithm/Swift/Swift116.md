# [Swift 문제풀이 116] 수 정렬하기

[문제 링크](https://www.acmicpc.net/problem/2750)

## 문제

N개의 수가 주어졌을 때, 이를 오름차순으로 정렬하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var stack: [Int] = []


for _ in 0..<input {
    let input = Int(readLine() ?? "") ?? 0
    stack.append(input)
}

stack.sorted().forEach { print($0) }
```
