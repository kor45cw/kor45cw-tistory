#[Swift 문제풀이 041] 알파벳 찾기 

[문제 링크](https://www.acmicpc.net/problem/10809)

##문제

알파벳 소문자로만 이루어진 단어 S가 주어진다. 각각의 알파벳에 대해서, 단어에 포함되어 있는 경우에는 처음 등장하는 위치를, 포함되어 있지 않은 경우에는 -1을 출력하는 프로그램을 작성하시오.

##풀이

```swift 
import Foundation

let line = readLine() ?? ""
let checkers = "abcdefghijklmnopqrstuvwxyz"
var result: [Int] = []

for checker in checkers {
    if let index = line.index(of: checker) {
        result.append(line.distance(from: line.startIndex, to: index))
    } else {
        result.append(-1)
    }
}

print(result.reduce("") { "\($0)\($1) " } )
```
