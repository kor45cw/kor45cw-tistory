# [Swift 문제풀이 061] 별찍기 - 7

[문제 링크](https://www.acmicpc.net/problem/2444)

## 문제

예제를 보고 별찍는 규칙을 유추한 뒤에 별을 찍어 보세요.

## 풀이

```swift 
import Foundation

let inputN = Int(readLine() ?? "") ?? 0


for index in 1..<2*inputN {
    var temp = ""
    if index <= inputN {
        for _ in 0..<inputN - index {
            temp += " "
        }
    } else {
        for _ in 2*inputN - index..<inputN {
            temp += " "
        }
    }

    if index <= inputN {
        for _ in inputN - index..<inputN {
            temp += "*"
        }
    } else {
        for _ in index-inputN..<inputN {
            temp += "*"
        }
    }

    if index <= inputN {
        for _ in inputN - index..<inputN-1 {
            temp += "*"
        }
    } else {
        for _ in index-inputN..<inputN-1 {
            temp += "*"
        }
    }

    print(temp)
}
```
