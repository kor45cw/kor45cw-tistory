# [Swift 문제풀이 096] 상근이의 친구들

[문제 링크](https://www.acmicpc.net/problem/5717)

## 문제

상근이의 남자 친구의 수와 여자 친구의 수가 주어졌을 때, 친구는 총 몇 명인지 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

var temp = 0
repeat {
    temp = (readLine() ?? "").split {
        $0 == " "
    }.compactMap {
        Int($0)
    }.reduce(0, +)

    if temp != 0 {
        print(temp)
    }
} while temp != 0
```
