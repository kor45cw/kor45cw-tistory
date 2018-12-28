# [Swift 문제풀이 188] 트럭 주차
 
[문제 링크](https://www.acmicpc.net/problem/2979)

## 문제

상근이는 트럭을 총 세 대 가지고 있다. 오늘은 트럭을 주차하는데 비용이 얼마나 필요한지 알아보려고 한다.

상근이가 이용하는 주차장은 주차하는 트럭의 수에 따라서 주차 요금을 할인해 준다.

트럭을 한 대 주차할 때는 1분에 한 대당 A원을 내야 한다. 두 대를 주차할 때는 1분에 한 대당 B원, 세 대를 주차할 때는 1분에 한 대당 C원을 내야 한다.

A, B, C가 주어지고, 상근이의 트럭이 주차장에 주차된 시간이 주어졌을 때, 주차 요금으로 얼마를 내야 하는지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

var time = [Int](repeating: 0, count: 100)
let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }


for _ in 0..<3 {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    for index in input[0]-1..<input[1]-1 {
        time[index] += 1
    }
}

var result = 0
for item in time {
    if item == 1 {
        result += input[0]
    } else if item == 2 {
        result += input[1] * 2
    } else if item == 3 {
        result += input[2] * 3
    }
}

print(result)
```
