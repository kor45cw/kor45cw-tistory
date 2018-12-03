# [Swift 문제풀이 170] 8진수, 10진수, 16진수
 
[문제 링크](https://www.acmicpc.net/problem/11816)

## 문제

정수 X가 주어진다. 정수 X는 항상 8진수, 10진수, 16진수 중에 하나이다.

8진수인 경우에는 수의 앞에 0이 주어지고, 16진수인 경우에는 0x가 주어진다.

X를 10진수로 바꿔서 출력하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

var input = (readLine() ?? "")

if input.hasPrefix("0x") {
    input.removeFirst()
    input.removeFirst()
    print(Int(input, radix: 16)!)
} else if input.hasPrefix("0") {
    input.removeFirst()
    print(Int(input, radix: 8)!)
} else {
    print(input)
}
```
