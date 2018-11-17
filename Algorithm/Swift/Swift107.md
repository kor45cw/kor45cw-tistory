# [Swift 문제풀이 107] 별 찍기 - 21

[문제 링크](https://www.acmicpc.net/problem/10996)

## 문제

예제를 보고 규칙을 유추한 뒤에 별을 찍어 보세요.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for index in 0..<2*input {
    var temp = index % 2 == 0 ? "*" : " "
    for index2 in 1..<input {
        if index % 2 == 1 {
            temp += index2 % 2 == 1 ? "*" : " "
        } else {
            temp += index2 % 2 == 0 ? "*" : " "
        }
    }
    print(temp)
}

```
