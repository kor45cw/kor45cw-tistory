# [Swift 문제풀이 085] A+B - 3

[문제 링크](https://www.acmicpc.net/problem/10950)

## 문제

두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation


let input = Int(readLine() ?? "") ?? 0
for _ in 0..<input {
    let result = (readLine() ?? "")
            .split {
                $0 == " "
            }
            .compactMap {
                Int($0)
            }.reduce(0, +)
    print(result)
}
```
