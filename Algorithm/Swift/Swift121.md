# [Swift 문제풀이 121] 수 정렬하기 2

[문제 링크](https://www.acmicpc.net/problem/2751)

## 문제

N개의 수가 주어졌을 때, 이를 오름차순으로 정렬하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var result: [Int] = []

for _ in 0..<input {
    let input = Int(readLine() ?? "") ?? 0
    result.append(input)
}

result.sorted().forEach { print($0) }
```
