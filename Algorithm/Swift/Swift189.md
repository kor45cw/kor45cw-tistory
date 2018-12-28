# [Swift 문제풀이 189] 꼬마 정민
 
[문제 링크](https://www.acmicpc.net/problem/11382)

## 문제

꼬마 정민이는 이제 A + B 정도는 쉽게 계산할 수 있다. 이제 A + B+ C를 계산할 차례이다!

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
print(input)
```
