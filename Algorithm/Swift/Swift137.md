# [Swift 문제풀이 137] 특별한 날

[문제 링크](https://www.acmicpc.net/problem/10768)

## 문제

2월 18일은 올해 CCC에 있어서 특별한 날이다.

사용자로부터 정수인 월과 일을 입력받아 날짜가 2월 18일인지 전인지 후인지를 출력하는 프로그램이다.

만약 날짜가 2월 18일 전이면, "Before"을 출력한다. 만약 날짜가 2월 18일 후면, "After"을 출력한다. 만약 2월 18일이라면 "Special" 을 출력한다.

## 풀이

```swift
import Foundation

let month = Int(readLine() ?? "") ?? 0
let day = Int(readLine() ?? "") ?? 0

if month > 2 {
    print("After")
} else if month < 2 {
    print("Before")
} else if day > 18 {
    print("After")
} else if day < 18 {
    print("Before")
} else {
    print("Special")
}
```
