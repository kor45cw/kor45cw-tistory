# [Swift 문제풀이 184] 개표
 
[문제 링크](https://www.acmicpc.net/problem/10102)

## 문제

A와 B가 한 오디션 프로의 결승전에 진출했다. 결승전의 승자는 심사위원의 투표로 결정된다.

심사위원의 투표 결과가 주어졌을 때, 어떤 사람이 우승하는지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation


_ = (readLine() ?? "")
let input = (readLine() ?? "")
let A = input.filter { $0 == "A" }.count
let B = input.filter { $0 == "B" }.count

if A == B { print("Tie") }
else if A > B { print("A") }
else { print("B") }
```
