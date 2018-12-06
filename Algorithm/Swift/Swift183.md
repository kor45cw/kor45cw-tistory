# [Swift 문제풀이 183] 파일 옮기기
 
[문제 링크](https://www.acmicpc.net/problem/11943)

## 문제

두 개의 바구니에 사과와 오렌지가 있다. 첫 번째 바구니에는 사과 A개와 오렌지 B개가 있으며 두 번째 바구니에는 사과 C개와 오렌지 D개가 있다.

당신은 한 바구니에 있는 과일 하나를 집어서 다른 바구니로 옮길 수 있다. 이런 식으로 과일을 옮길 때, 한 바구니에는 사과만 있게 하고 다른 쪽에는 오렌지만 있게 하려고 한다.

앞서 말한 조건을 만족하도록 과일을 옮길 때, 과일을 옮기는 최소 횟수를 구하는 프로그램을 작성하여라.

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
let input2 = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

let a = input2[0] + input[1]
let b = input[0] + input2[1]

print(a > b ? b : a)
```
