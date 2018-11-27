# [Swift 문제풀이 125] 연세대학교

[문제 링크](https://www.acmicpc.net/problem/15680)

## 문제

연세대학교의 영문명은 YONSEI, 슬로건은 Leading the Way to the Future이다.

이를 출력하는 프로그램을 작성해보도록 하자.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

print(input == 0 ? "YONSEI" : "Leading the Way to the Future")
```
