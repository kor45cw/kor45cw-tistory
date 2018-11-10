# [Swift 문제풀이 089] 홍익대학교

[문제 링크](https://www.acmicpc.net/problem/16394)

## 문제

홍익대학교는 1946년에 개교하였다.

특정 년도가 주어졌을 때, 그 해가 개교 몇 주년인지 출력하라.

단, 홍익대학교는 없어지지 않는다고 가정한다.

## 풀이

```swift
import Foundation


let inputN = Int(readLine() ?? "") ?? 0

print(inputN - 1946)
```
