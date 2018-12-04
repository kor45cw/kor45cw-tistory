# [Swift 문제풀이 178] 과제 안 내신 분..?
 
[문제 링크](https://www.acmicpc.net/problem/5597)

## 문제

X대학 M교수님은 프로그래밍 수업을 맡고 있습니다. 교실엔 학생이 30명이 있는데, 학생 명부엔 각 학생별로 1번부터 30번까지 출석번호가 붙어 있습니다.

교수님이 내준 특별과제를 28명이 제출했는데, 그 중에서 제출 안 한 학생 2명의 출석번호를 구하는 프로그램을 작성하세요.

## 풀이

```swift
import Foundation

var temp = [Int](repeating: 0, count: 30)

for _ in 0..<28 {
    let input = Int(readLine() ?? "") ?? 0
    temp[input-1] = 1
}

for index in 0..<30 {
    if temp[index] == 0 {
        print(index+1)
    }
}
```
