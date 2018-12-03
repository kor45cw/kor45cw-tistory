# [Swift 문제풀이 168] 짝수를 찾아라
 
[문제 링크](https://www.acmicpc.net/problem/3058)

## 문제

7개의 자연수가 주어질 때, 이들 중 짝수인 자연수들을 모두 골라 그 합을 구하고, 고른 짝수들 중 최솟값을 찾는 프로그램을 작성하시오.

예를 들어, 7개의 자연수 13, 78, 39, 42, 54, 93, 86가 주어지면 이들 중 짝수는 78, 42, 54, 86이므로 그 합은 78 + 42 + 54 + 86 = 260 이 되고, 42 < 54 < 78 < 86 이므로 짝수들 중 최솟값은 42가 된다.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }.filter { $0 % 2 == 0 }
    let sum = input.reduce(0, +)

    print("\(sum) \(input.min()!)")
}
```
