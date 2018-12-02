# [Swift 문제풀이 153] 더하기 

[문제 링크](https://www.acmicpc.net/problem/10822)

## 문제

숫자와 콤마로만 이루어진 문자열 S가 주어진다. 이때, S에 포함되어있는 자연수의 합을 구하는 프로그램을 작성하시오.

S의 첫 문자와 마지막 문자는 항상 숫자이고, 콤마는 연속해서 주어지지 않는다. 주어지는 수는 항상 자연수이다.

## 풀이

```swift
import Foundation

let first = (readLine() ?? "").split { $0 == "," }.compactMap { Int($0) }.reduce(0, +)
print(first)
```
