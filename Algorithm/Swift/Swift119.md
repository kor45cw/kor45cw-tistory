# [Swift 문제풀이 119] 괄호 없는 사칙연산

[문제 링크](https://www.acmicpc.net/problem/16504)

## 문제

이접기와 수학을 좋아하는 주성이는 종이접기와 수학을 한꺼번에 할 수 있는 놀이를 찾아냈다. 바로 N×N 크기를 가지는 색종이의 각 칸에 수를 적어놓고, 색종이를 반으로 접을 때마다 겹치는 부분의 수들을 더하는 것이다. 그리고 이 작업을 색종이를 더는 접을 수 없을 때까지 반복했을 때, 가장 마지막에 남는 수를 구하는 놀이이다.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var result = 0

for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
    result += input
}

print(result)
```
