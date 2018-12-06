# [Swift 문제풀이 185] 오타맨 고창영
 
[문제 링크](https://www.acmicpc.net/problem/2711)

## 문제

고창영은 맨날 오타를 낸다. 창영이가 오타를 낸 문장과 오타를 낸 위치가 주어졌을 때, 오타를 지운 문자열을 출력하는 프로그램을 작성하시오.

창영이는 오타를 반드시 1개만 낸다.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }
    var s = String(input[1])
    var n = Int(input[0])!-1
    if let index = s.index(s.startIndex, offsetBy: n, limitedBy: s.endIndex) {
        s.remove(at: index)
        print(s)
    } else {
        print("\(n) is out of range")
    }
}
```
