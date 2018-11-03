# [Swift 문제풀이 069] 별찍기 - 13

[문제 링크](https://www.acmicpc.net/problem/2523)

## 문제

 예제를 보고 별찍는 규칙을 유추한 뒤에 별을 찍어 보세요.


## 풀이

```swift 
import Foundation

let first = Int(readLine() ?? "") ?? 0

for index in 1...2*first-1 {
    var temp = ""
    if index <= first {
        for _ in 0..<index {
            temp += "*"
        }
    } else {
        for _ in index...2*first-1 {
            temp += "*"
        }
    }

    print(temp)
}
```
