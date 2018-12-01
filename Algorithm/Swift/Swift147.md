# [Swift 문제풀이 147] 더하기 3 

[문제 링크](https://www.acmicpc.net/problem/11023)

## 문제

수 N개가 주어졌을 때, N개의 합을 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
print(input)
```
