# [Swift 문제풀이 111] 더하기

[문제 링크](https://www.acmicpc.net/problem/14918)

## 문제

두 개의 정수 입력 a, b를 받아서 a+b를 출력하시오.

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)

print(input)
```
