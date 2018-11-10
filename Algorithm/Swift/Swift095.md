# [Swift 문제풀이 095] 별 찍기 - 20

[문제 링크](https://www.acmicpc.net/problem/10995)

## 문제

예제를 보고 규칙을 유추한 뒤에 별을 찍어 보세요.

## 풀이

```swift
import Foundation


let inputN = Int(readLine() ?? "") ?? 0
var temp = ""

for _ in 0..<inputN {
    temp += "* "
}

for index in 0..<inputN {
    if index % 2 == 1 {
        print(" \(temp)")
    } else {
        print(temp)
    }
}
```
