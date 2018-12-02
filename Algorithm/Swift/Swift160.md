# [Swift 문제풀이 160] 점수 계산
 
[문제 링크](https://www.acmicpc.net/problem/2822)

## 문제

상근이는 퀴즈쇼의 PD이다. 이 퀴즈쇼의 참가자는 총 8개 문제를 푼다. 참가자는 각 문제를 풀고, 그 문제를 풀었을 때 얻는 점수는 문제를 풀기 시작한 시간부터 경과한 시간과 난이도로 결정한다. 문제를 풀지 못한 경우에는 0점을 받는다. 참가자의 총 점수는 가장 높은 점수 5개의 합이다. 

상근이는 잠시 여자친구와 전화 통화를 하느라 참가자의 점수를 계산하지 않고 있었다. 참가자의 8개 문제 점수가 주어졌을 때, 총 점수를 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

var temp: [Int] = []

for _ in 0..<8 {
    temp.append(Int(readLine() ?? "") ?? 0)
}

let result = Array(temp.sorted().reversed())
let value = result[0]+result[1]+result[2]+result[3]+result[4]
var tempValue: [Int] = []

for index in 0..<5 {
    tempValue.append(temp.firstIndex(of: result[index])!)
}

print(value)
print(tempValue.sorted().reduce("") {"\($0)\($1+1) "})
```
