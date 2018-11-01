# [Swift 문제풀이 067] 별 찍기 - 16

[문제 링크](https://www.acmicpc.net/problem/10991)

## 문제

예제를 보고 별 찍는 규칙을 유추한 뒤에 별을 찍어 보세요.


## 풀이

```swift 
import Foundation

let inputN = Int(readLine() ?? "") ?? 0

for index in 0..<inputN {
    var temp = ""
    for _ in 0..<inputN-index-1 {
        temp += " "
    }
    for _ in inputN-index...inputN {
        temp += "* "
    }
    
    print(temp)
}
```
