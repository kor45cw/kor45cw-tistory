# [Swift 문제풀이 142] 싱기한 네자리 숫자

[문제 링크](https://www.acmicpc.net/problem/6679)

## 문제

싱기한 네자리 숫자란, [1000,9999]인 10진수 숫자중에서,  다음의 조건을 만족하는 숫자를 말한다.

숫자를 10진수, 12진수, 16진수로 나타낸 다음, 각각의 숫자에 대해, 각 숫자의 자리수를 더했을 때, 세 값이 모두 같아야 한다.

여러분은 싱기한 네자리 숫자를 모두 출력해야 한다.

## 풀이

```swift
import Foundation

for index in 1000...9999 {
    let result1 = String(index).compactMap {
        Int(String($0))
    }.reduce(0, +)
    let result2 = String(index, radix: 12).compactMap {
        Int(String($0), radix: 12)
    }.reduce(0, +)


    if result1 == result2 {
        let result3 = String(index, radix: 16).compactMap {
            Int(String($0), radix: 16)
        }.reduce(0, +)
        if result1 == result3 {
            print(index)
        }
    }
}
```
