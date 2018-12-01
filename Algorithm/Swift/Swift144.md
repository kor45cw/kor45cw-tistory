# [Swift 문제풀이 144] 생일

[문제 링크](https://www.acmicpc.net/problem/5635)

## 문제

어떤 반에 있는 학생들의 생일이 주어졌을 때, 가장 나이가 어린 사람과 가장 많은 사람을 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
var maxName = ""
var minName = ""
var max = ""
var min = ""

for _ in 1...input {
    let input = (readLine() ?? "").split { $0 == " " }.map { String($0) }
    var temp = "\(input[3])"
    temp += Int(input[2])! < 10 ? "0\(input[2])" : "\(input[2])"
    temp += Int(input[1])! < 10 ? "0\(input[1])" : "\(input[1])"

    if temp > max {
        maxName = input[0]
        max = temp
    }
    if temp < min || min.isEmpty {
        minName = input[0]
        min = temp
    }
}

print(maxName)
print(minName)
```
