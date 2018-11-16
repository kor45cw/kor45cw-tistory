# [Swift 문제풀이 104] N번째 큰 수

[문제 링크](https://www.acmicpc.net/problem/2693)

## 문제

배열 A가 주어졌을 때, N번째 큰 값을 출력하는 프로그램을 작성하시오.

배열 A의 크기는 항상 10이고, 자연수만 가지고 있다. N은 항상 3이다.

## 풀이

```swift
import Foundation

let inputN = Int(readLine() ?? "") ?? 0

for _ in 0..<inputN {
    let input = (readLine() ?? "").split {$0 == " "}.compactMap { Int($0) }
    print(input.sorted()[input.count-3])
}
```
