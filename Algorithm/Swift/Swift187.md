# [Swift 문제풀이 187] 직각삼각형
 
[문제 링크](https://www.acmicpc.net/problem/4153)

## 문제

과거 이집트인들은 각 변들의 길이가 3, 4, 5인 삼각형이 직각 삼각형인것을 알아냈다. 주어진 세변의 길이로 삼각형이 직각인지 아닌지 구분하시오.

## 풀이

```swift
import Foundation

while true {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.sorted()
    if input.reduce(0, +) == 0 { break }
    if input[0] * input[0] + input[1] * input[1] == input[2] * input[2] {
        print("right")
    } else {
        print("wrong")
    }
}

```
