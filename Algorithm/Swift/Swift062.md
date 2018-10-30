# [Swift 문제풀이 062] A+B - 8

[문제 링크](https://www.acmicpc.net/problem/11022)

## 문제

두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.

## 풀이

```swift 
import Foundation

let inputN = Int(readLine() ?? "") ?? 0

for index in 1...inputN {
    let inputArr = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    print("Case #\(index): \(inputArr[0]) + \(inputArr[1]) = \(inputArr[0] + inputArr[1])")
}
```
