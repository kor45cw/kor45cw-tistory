# [Swift 문제풀이 059] 별찍기 - 6

[문제 링크](https://www.acmicpc.net/problem/2443)

## 문제

첫째 줄에는 별 2 * N-1개, 둘째 줄에는 별 2 * N-3개, ..., N번째 줄에는 별 1개를 찍는 문제

별은 가운데를 기준으로 대칭이어야 한다.

## 풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0

for index in 0..<line {
    var temp = ""

    for _ in 0..<index {
        temp += " "
    }

    for _ in 0..<(line*2 - (2*index + 1)) {
        temp += "*"
    }

    print(temp)
}
```
