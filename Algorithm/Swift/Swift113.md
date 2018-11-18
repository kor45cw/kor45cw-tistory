# [Swift 문제풀이 113] 사분면

[문제 링크](https://www.acmicpc.net/problem/9610)

## 문제

2차원 좌표 상의 여러 점의 좌표 (x,y)가 주어졌을 때, 각 사분면과 축에 점이 몇 개 있는지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var Q1 = 0
var Q2 = 0
var Q3 = 0
var Q4 = 0
var AXIS = 0


for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

    if input[0] == 0 || input[1] == 0 {
        AXIS += 1
    } else if input[0] > 0 {
        if input[1] > 0 {
            Q1 += 1
        } else {
            Q4 += 1
        }
    } else {
        if input[1] > 0 {
            Q2 += 1
        } else {
            Q3 += 1
        }
    }
}

print("Q1: \(Q1)")
print("Q2: \(Q2)")
print("Q3: \(Q3)")
print("Q4: \(Q4)")
print("AXIS: \(AXIS)")
```
