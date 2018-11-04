# [Swift 문제풀이 075] 5와 6의 차이

[문제 링크](https://www.acmicpc.net/problem/2864)

## 문제

상근이는 2863번에서 표를 너무 열심히 돌린 나머지 5와 6을 헷갈리기 시작했다.

싱근이가 숫자 5를 볼 때, 5로 볼 때도 있지만, 6으로 잘못 볼 수도 있고, 6을 볼 때는, 6으로 볼 때도 있지만, 5로 잘못 볼 수도 있다.

두 수 A와 B가 주어졌을 때, 상근이는 이 두 수를 더하려고 한다. 이때, 상근이가 구할 수 있는 두 수의 가능한 합 중, 최솟값과 최댓값을 구해 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

func makeMaxInteger(_ input: String) -> Int {
    return Int(input.replacingOccurrences(of: "5", with: "6")) ?? 0
}

func makeMinInteger(_ input: String) -> Int {
    return Int(input.replacingOccurrences(of: "6", with: "5")) ?? 0
}

let input = (readLine() ?? "").split { $0 == " " }.map { String($0) }

let min = makeMinInteger(input[0]) + makeMinInteger(input[1])
let max = makeMaxInteger(input[0]) + makeMaxInteger(input[1])

print("\(min) \(max)")
```
