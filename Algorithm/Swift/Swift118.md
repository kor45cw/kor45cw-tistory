# [Swift 문제풀이 118] 괄호 없는 사칙연산

[문제 링크](https://www.acmicpc.net/problem/16503)

## 문제

사칙연산에서 곱셈과 나눗셈은 덧셈과 뺄셈보다 먼저 계산한다. 덧셈과 뺄셈을 먼저 계산하고 싶을 때는 보통 가장 큰 연산 우선순위를 가지는 괄호를 사용하여 연산 순서를 지정한다. 예를 들어, 아래의 식은 연산 순서에 따라 두 가지 다른 결과가 나올 수 있다.

- (2 + 3) × 4 = 20
- 2 + (3 × 4) = 14

연산 우선순위가 같은 곱셈과 나눗셈 또는 덧셈과 뺄셈만 있는 식에서는 보통 왼쪽에서 오른쪽 순서로 연산을 한다. 하지만 이런 상황에도 연산 순서에 따라 아래와 같이 두 가지 다른 결과가 나올 수 있다.

- (6 ÷ 2) × 3 = 9
- 6 ÷ (2 × 3) = 1

만약 곱셈, 나눗셈, 덧셈, 뺄셈의 4가지 연산자의 연산 우선순위가 동등하다고 할 때, 괄호 없는 식에서 서로 다른 연산 순서의 계산 결과를 구하여라.

## 풀이

```swift
import Foundation

func cal(left: Int, mid: String, right: Int) -> Int {
    switch mid {
    case "+":
        return left + right
    case "-":
        return left - right
    case "*":
        return left * right
    case "/":
        return left / right
    default:
        return 0
    }
}

let input = (readLine() ?? "").split { $0 == " " }.map { String($0) }

let leftFirst = cal(left: Int(input[0]) ?? 0, mid: input[1], right: Int(input[2]) ?? 0)
let leftResult = cal(left: leftFirst, mid: input[3], right: Int(input[4]) ?? 0)


let rightFirst = cal(left: Int(input[2]) ?? 0, mid: input[3], right: Int(input[4]) ?? 0)
let rightResult = cal(left: Int(input[0]) ?? 0, mid: input[1], right: rightFirst)

if leftResult > rightResult {
    print(rightResult)
    print(leftResult)
} else {
    print(leftResult)
    print(rightResult)
}
```
