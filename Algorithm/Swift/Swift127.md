# [Swift 문제풀이 127] 과목선택

[문제 링크](https://www.acmicpc.net/problem/11948)

## 문제

JOI는 물리, 화학, 생물, 지구과학, 역사, 지리 총 6 과목의 시험을 봤다. 각 시험의 만점은 100점이다.

JOI는 물리, 화학, 생물, 지구과학 4과목 중에서 3 과목을 선택하고 역사, 지리 2 과목 중에서 한 과목을 선택한다.

시험 점수의 합이 가장 높게 나오도록 과목을 선택할 때, JOI가 선택한 과목의 시험 점수의 합을 구하시오.

## 풀이

```swift
import Foundation

var tempFront: [Int] = []
var tempBack: [Int] = []


for index in 0..<6 {
    let input = Int(readLine() ?? "") ?? 0
    if index >= 4 {
        tempBack.append(input)
    } else {
        tempFront.append(input)
    }
}

let result = tempBack.reduce(0, +) + tempFront.reduce(0, +) - tempBack.min()! - tempFront.min()!

print(result)
```
