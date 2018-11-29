# [Swift 문제풀이 135] 경기 결과

[문제 링크](https://www.acmicpc.net/problem/5523)

## 문제

A와 B가 게임을 한다. 게임은 N번의 라운드로 이루어져 있다. 각 라운드에서는, 더 많은 점수를 얻은 사람이 그 라운드의 승자가 된다. 즉, A의 점수가 B의 점수보다 크면 i번째 라운드는 A의 승리이며, B의 점수가 A의 점수보다 크면 i번째 라운드는 B의 승리이다. 무승부인 경우에는 아무도 승리하지 않는다.

N번의 라운드에서의 A와 B의 점수가 주어졌을 때, A가 이긴 횟수와, B가 이긴 횟수를 출력하는 프로그램을 만들어라.

## 풀이

```swift
import Foundation

let line = Int(readLine() ?? "") ?? 0
var countA = 0
var countB = 0

for _ in 0..<line {
    let input = (readLine() ?? "").split { $0 == " " }
    let A = Int(input[0]) ?? 0
    let B = Int(input[1]) ?? 0
    if A > B {
        countA += 1
    } else if A < B {
        countB += 1
    }
}

print("\(countA) \(countB)")
```
