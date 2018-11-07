# [Swift 문제풀이 076] 세수정렬

[문제 링크](https://www.acmicpc.net/problem/2752)

## 문제

동규는 세수를 하다가 정렬이 하고싶어졌다.

숫자 세 개를 생각한 뒤에, 이를 오름차순으로 정렬하고 싶어 졌다.

숫자 세 개가 주어졌을 때, 가장 작은 수, 그 다음 수, 가장 큰 수를 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let line = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
let result = line.sorted().reduce("") { "\($0)\($1) " }

print(result)
```
