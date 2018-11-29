# [Swift 문제풀이 136] 다각형의 대각선

[문제 링크](https://www.acmicpc.net/problem/3049)

## 문제

세 대각선이 한 점에서 만나지 않는 볼록 N각형이 주어졌을 때, 대각선의 교차점의 개수를 세는 프로그램을 작성하시오.

아래 그림은 위의 조건을 만족하는 한 육각형의 교차점 그림이다.

## 풀이

```swift
import Foundation

let n = Int(readLine() ?? "") ?? 0

let result = (n * (n-1) * (n-2) * (n-3)) / 24

print(result)
```
