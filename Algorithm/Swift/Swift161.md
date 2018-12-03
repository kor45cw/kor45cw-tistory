# [Swift 문제풀이 161] 네 번째 점
 
[문제 링크](https://www.acmicpc.net/problem/3009)

## 문제

세 점이 주어졌을 때, 축에 평행한 직사각형을 만들기 위해서 필요한 네 번째 점을 찾는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

var tempX: [Int] = []
var tempY: [Int] = []

for _ in 0..<3 {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    if let index = tempX.firstIndex(of: input[0]) {
        tempX.remove(at: index)
    } else {
        tempX.append(input[0])
    }

    if let index = tempY.firstIndex(of: input[1]) {
        tempY.remove(at: index)
    } else {
        tempY.append(input[1])
    }
}

print("\(tempX.first!) \(tempY.first!)")
```
