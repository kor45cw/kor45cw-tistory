# [Swift 문제풀이 123] A+B - 4

[문제 링크](https://www.acmicpc.net/problem/10951)

## 문제

두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

while true {
    let input = (readLine() ?? "")
    if input.isEmpty { break }
    let result = input.split { $0 == " " }.compactMap { Int($0) }.reduce(0, +)
    print(result)
}
```
