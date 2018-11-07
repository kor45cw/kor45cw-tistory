# [Swift 문제풀이 084] A+B - 5

[문제 링크](https://www.acmicpc.net/problem/10952)

## 문제

두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

var temp = 0

repeat {
    temp = (readLine() ?? "")
            .split {
                $0 == " "
            }
            .compactMap {
                Int($0)
            }.reduce(0, +)
    if temp != 0 {
        print(temp)
    }
} while temp != 0
```
