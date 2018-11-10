# [Swift 문제풀이 094] 주사위 게임

[문제 링크](https://www.acmicpc.net/problem/10103)

## 문제

창영이와 상덕이는 게임을 하고 있다.

게임을 시작하는 시점에서, 두 사람은 점수는 모두 100점이다.

게임은 여섯 면 주사위를 사용하며, 라운드로 진행된다. 매 라운드마다, 각 사람은 주사위를 던진다. 낮은 숫자가 나온 사람은 상대편 주사위에 나온 숫자만큼 점수를 잃게 된다. 두 사람의 주사위가 같은 숫자가 나온 경우에는 아무도 점수를 잃지 않는다.

게임이 끝난 이후에 두 사람의 점수를 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation


var tempA = 100
var tempB = 100
let inputN = Int(readLine() ?? "") ?? 0


for _ in 0..<inputN {
    let inputN = (readLine() ?? "").split { $0 == " " }.compactMap {Int($0)}
    if inputN[0] > inputN[1] {
        tempB -= inputN[0]
    } else if inputN[0] < inputN[1] {
        tempA -= inputN[1]
    }
}

print(tempA)
print(tempB)
```
