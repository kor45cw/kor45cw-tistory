# [Swift 문제풀이 190] 이진수 변환
 
[문제 링크](https://www.acmicpc.net/problem/10829)

## 문제

자연수 N이 주어진다. N을 이진수로 바꿔서 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
print(String(input, radix: 2))
```
