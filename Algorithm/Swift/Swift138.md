# [Swift 문제풀이 138] 대회 자리

[문제 링크](https://www.acmicpc.net/problem/10768)

## 문제

이번 ACM-ICPC 대회의 자리는 참가자들이 직접 정한다. 참가자들은 예비 소집일에 자신이 원하는 자리를 미리 정해놓았고, 대회 당일에 어제 적어놓은 자리에 앉으면 된다. 여러명이 같은 자리를 적어논 경우에는, 먼저 도착한 사람이 그 자리에 앉게되고, 앉지 못한 사람은 대회에 참가할 수 없다.

각 사람이 선호하는 자리가 주어졌을 때, 대회에 참가하지 못하는 사람의 수를 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    var count = 0
    var chair = [Int](repeating: 0, count: input[1])
    for _ in 0..<input[0] {
        let input = Int(readLine() ?? "") ?? 0
        if chair[input-1] == 1 { count += 1; continue }
        chair[input-1] = 1
    }
    print(count)
}
```
