# [Swift 문제풀이 180] 모음의 개수
 
[문제 링크](https://www.acmicpc.net/problem/10987)

## 문제

알파벳 소문자로만 이루어진 단어가 주어진다. 이때, 모음(a, e, i, o, u)의 개수를 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

let checker = ["a", "e", "i", "o", "u"]

let input = (readLine() ?? "")
var count = 0

for item in input {
    if checker.contains(String(item)) { count += 1 }
}

print(count)
```
