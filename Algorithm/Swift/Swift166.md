# [Swift 문제풀이 166] 카드게임
 
[문제 링크](https://www.acmicpc.net/problem/10801)

## 문제

두 사람 A와 B는 1부터 10까지의 숫자가 하나씩 적힌 열 장의 카드로 ‘게임’을 한다. 게임은 총 열 번의 ‘라운드’로 구성되고, 각 라운드 마다 자신이 가지고 있는 카드 중 하나를 제시하고, 한 번 제시한 카드는 버린다. 게임 승패는 다음과 같이 결정된다. 

각 라운드는 더 높은 숫자를 제시한 사람이 승리하고, 제시한 숫자가 같은 경우는 비긴다. 
열 번의 라운드에서 더 많은 라운드를 승리한 사람이 게임을 승리하고, 승리한 라운드 횟수가 동일한 경우 비긴다. 
다음은 게임의 한 예로, 각 라운드마다 A와 B가 제시한 카드의 숫자와 각 라운드의 승자를 보여준다. (비긴 라운드는 D로 표시함)

A는 5번의 라운드에서 승리하고 B는 4번의 라운드에서 승리하였으므로, 이 게임은 A가 승리한다. 

라운드 순서대로 A와 B가 제시한 카드의 숫자가 주어졌을 때, 게임의 승자를 판단하는 프로그램을 작성하시오. 

## 풀이

```swift
import Foundation

let inputA = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
let inputB = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
var count = 0

for index in 0..<inputA.count {
    if inputA[index] > inputB[index] {
        count += 1
    }
    if inputA[index] < inputB[index] {
        count -= 1
    }
}

if count > 0 {
    print("A")
} else if count < 0 {
    print("B")
} else {
    print("D")
}

```
