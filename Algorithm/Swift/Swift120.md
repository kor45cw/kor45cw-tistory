# [Swift 문제풀이 120] 별 찍기 - 9

[문제 링크](https://www.acmicpc.net/problem/2446)

## 문제

예제를 보고 규칙을 유추한 뒤에 별을 찍어 보세요.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for index in 0..<2*input-1 {
    let emptySpace = index+1 > input ? 2*input - index - 2 : index
    let tempInput = input - emptySpace
    var temp = ""

    for _ in 0..<emptySpace {
        temp += " "
    }

    for _ in 0..<tempInput*2 {
        temp += "*"
    }

    temp.removeLast()
    print(temp)
}
```
