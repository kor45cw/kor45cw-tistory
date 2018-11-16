# [Swift 문제풀이 103] 정수의 개수

[문제 링크](https://www.acmicpc.net/problem/10821)

## 문제

숫자와 콤마로만 이루어진 문자열 S가 주어진다. 이때, S에 포함되어있는 정수의 개수를 구하는 프로그램을 작성하시오.

S의 첫 문자와 마지막 문자는 항상 숫자이고, 콤마는 연속해서 주어지지 않는다. 또, 0으로 시작하는 정수는 주어지지 않는다.

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == "," }.count

print(input)
```
