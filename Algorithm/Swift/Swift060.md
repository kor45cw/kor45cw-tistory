# [Swift 문제풀이 060] 별찍기 - 8

[문제 링크](https://www.acmicpc.net/problem/2445)

## 문제

예제를 보고 별찍는 규칙을 유추한 뒤에 별을 찍어 보세요.

## 풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0

for index in 1...line*2-1 {
    var temp = ""

    if index <= line {
        for _ in 0..<index {
            temp += "*"
        }
    } else {
        for _ in index...line*2-1 {
            temp += "*"
        }
    }

    if index <= line {
        for _ in index..<line*2-index {
            temp += " "
        }
    } else {
        for _ in line*2-index..<index {
            temp += " "
        }
    }

    if index <= line {
        for _ in 0..<index {
            temp += "*"
        }
    } else {
        for _ in index...line*2-1 {
            temp += "*"
        }
    }

    print(temp)
}
```
