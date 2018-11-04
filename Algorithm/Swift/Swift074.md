# [Swift 문제풀이 074] 더하기

[문제 링크](https://www.acmicpc.net/problem/9085)

## 문제

자연수 N개를 주면 합을 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    _ = readLine()
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
    print(input)
}
```
