# [Swift 문제풀이 155] 문자열
 
[문제 링크](https://www.acmicpc.net/problem/9086)

## 문제

문자열을 입력으로 주면 문자열의 첫 글자와 마지막 글자를 출력하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = readLine() ?? ""
    print("\(input.first!)\(input.last!)")
}
```
