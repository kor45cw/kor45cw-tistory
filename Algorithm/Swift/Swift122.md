# [Swift 문제풀이 122] !밀비 급일

[문제 링크](https://www.acmicpc.net/problem/11365)

## 문제

당신은 길을 가다가 이상한 쪽지를 발견했다. 그 쪽지에는 암호가 적혀 있었는데, 똑똑한 당신은 암호가 뒤집으면 해독된다는 것을 발견했다.

이 암호를 해독하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

while true {
    let input = readLine() ?? ""
    if input == "END" { break }
    print(String(input.reversed()))
}
```
