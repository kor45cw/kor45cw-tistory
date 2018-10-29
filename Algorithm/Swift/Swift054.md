#[Swift 문제풀이 054] 별찍기 - 12

[문제 링크](https://www.acmicpc.net/problem/2522)

##문제

예제를 보고 별찍는 규칙을 유추한 뒤에 별을 찍어 보세요.

##풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0

for index in 1...2*line-1 {
    var result = ""
    if index <= line {
        for _ in 0..<line - index {
            result += " "
        }
        for _ in line - index..<line {
            result += "*"
        }
    } else {
        for _ in line..<index {
            result += " "
        }
        for _ in index...2*line-1 {
            result += "*"
        }
    }

    print(result)
}
```
