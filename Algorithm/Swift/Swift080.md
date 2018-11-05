# [Swift 문제풀이 080] 소수 찾기

[문제 링크](https://www.acmicpc.net/problem/1978)

## 문제

주어진 수 N개 중에서 소수가 몇 개인지 찾아서 출력하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

func isPrime(_ input: Int) -> Bool {
    if input == 1 { return false }
    for index in 2..<input {
        if input % index == 0 {
            return false
        }
    }

    return true
}

_ = readLine()
let result = (readLine() ?? "")
        .split { $0 == " " }
        .compactMap { Int($0) }
        .filter { isPrime($0) }.count

print(result)
```
