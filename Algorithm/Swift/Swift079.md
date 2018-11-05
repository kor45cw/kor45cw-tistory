# [Swift 문제풀이 079] 별 찍기 - 17

[문제 링크](https://www.acmicpc.net/problem/10992)

## 문제

예제를 보고 규칙을 유추한 뒤에 별을 찍어 보세요.


## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for index in 1..<input {
    var temp = ""
    for _ in 0..<input-index {
        temp += " "
    }
    temp += "*"

    for _ in input-index+1..<input {
        temp += " "
    }

    if index == 1 { print(temp); continue }

    for _ in 1..<index-1 {
        temp += " "
    }
    temp += "*"

    print(temp)
}

var temp = ""
for _ in 0..<2*input-1 {
    temp += "*"
}

print(temp)
```
