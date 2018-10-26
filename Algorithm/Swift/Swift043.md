#[Swift 문제풀이 043] 단어 공부

[문제 링크](https://www.acmicpc.net/problem/1157)

##문제

알파벳 대소문자로 된 단어가 주어지면, 이 단어에서 가장 많이 사용된 알파벳이 무엇인지 알아내는 프로그램을 작성하시오. 단, 대문자와 소문자를 구분하지 않는다.

##풀이

```swift 
import Foundation

var items: [Character: Int] = [:]
let line = (readLine() ?? "").uppercased()

for character in line {
    if let value = items[character] {
        items[character] = value + 1
    } else {
        items[character] = 1
    }
}

let maxValue = items.values.max()
let result = items.filter { $0.value == maxValue }
if result.count != 1 {
    print("?")
} else {
    print(result.first!.key)
}
```
