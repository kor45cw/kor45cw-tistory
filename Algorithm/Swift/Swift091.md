# [Swift 문제풀이 091] 와이버스 부릉부릉

[문제 링크](https://www.acmicpc.net/problem/14645)

## 문제

버스 운전수 비와이 씨가 운전하는 버스(verse아님 ㅎ)는 N개의 정거장을 거친 후 종착역에 도착한다. 각 정거장은 내릴 인원수와 올라탈 인원수가 정해져 있다. 종착역에 도착하면 버스에 타고 있던 모든 사람이 내린다.


## 풀이

```swift
import Foundation

let inputN = (readLine() ?? "").split { $0 == " " }.compactMap {Int($0)}

for _ in 0..<3 {
    _ = readLine()
}
print("바와이")
```
