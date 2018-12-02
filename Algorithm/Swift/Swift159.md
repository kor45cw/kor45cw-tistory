# [Swift 문제풀이 159] 개수 세기
 
[문제 링크](https://www.acmicpc.net/problem/10807)

## 문제

총 N개의 정수가 주어졌을 때, 정수 v가 몇 개인지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

_ = (readLine() ?? "")
let input = (readLine() ?? "").split {$0 == " "}.compactMap { Int($0) }
let checker = Int(readLine() ?? "") ?? 0


print(input.filter { $0 == checker }.count)
```
