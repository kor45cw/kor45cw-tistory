# [Swift 문제풀이 143] 주사위

[문제 링크](https://www.acmicpc.net/problem/9295)

## 문제

오늘은 갑자기 주사위를 던지고 싶다.

그런데 코딩도 하고 싶다.

그럼 같이할까?

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for index in 1...input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
    print("Case \(index): \(input)")
}
```
