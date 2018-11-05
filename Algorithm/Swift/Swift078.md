# [Swift 문제풀이 078] 대소문자 바꾸기

[문제 링크](https://www.acmicpc.net/problem/2744)

## 문제

영어 소문자와 대문자로 이루어진 단어를 입력받은 뒤, 대문자는 소문자로, 소문자는 대문자로 바꾸어 출력하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

func swapCases(_ str: String) -> String {
    var result = ""
    for c in str {
        let s = String(c)
        let lo = s.lowercased()
        let up = s.uppercased()
        result += (s == lo) ? up : lo
    }
    return result
}

let input = readLine() ?? ""

print(swapCases(input))
```
