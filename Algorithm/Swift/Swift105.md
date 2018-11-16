# [Swift 문제풀이 105] 공 바꾸기

[문제 링크](https://www.acmicpc.net/problem/10813)

## 문제

도현이는 바구니를 총 N개 가지고 있고, 각각의 바구니에는 1번부터 N번까지 번호가 매겨져 있다. 바구니에는 공이 1개씩 들어있고, 처음에는 바구니에 적혀있는 번호와 같은 번호가 적힌 공이 들어있다.

도현이는 앞으로 M번 공을 바꾸려고 한다. 도현이는 공을 바꿀 바구니 2개를 선택하고, 두 바구니에 들어있는 공을 서로 교환한다.

공을 어떻게 바꿀지가 주어졌을 때, M번 공을 바꾼 이후에 각 바구니에 어떤 공이 들어있는지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split {$0 == " "}.compactMap { Int($0) }
var result: [Int] = []

for index in 1...input[0] {
    result.append(index)
}

for _ in 0..<input[1] {
    let input = (readLine() ?? "").split {$0 == " "}.compactMap { Int($0) }
    let tempA = result[input[0]-1]
    let tempB = result[input[1]-1]
    result[input[1]-1] = tempA
    result[input[0]-1] = tempB
}

print(result.reduce("") { "\($0)\($1) " })
```
