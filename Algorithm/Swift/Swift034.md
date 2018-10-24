#[Swift 문제풀이 034] 별찍기 - 11

[문제 링크](https://www.acmicpc.net/problem/2448)

##문제

예제를 보고 별찍는 규칙을 유추한 뒤에 별을 찍어 보세요.

##풀이

```swift 
import Foundation

let inputN = Int(readLine() ?? "") ?? 0
var result = Array<String>()

result.append("  *   ")
result.append(" * *  ")
result.append("***** ")

func makeStar(value: Double) {
    let count = result.count
    var input = ""
    for _ in 0..<Int(value) {
        input += "   "
    }

    for index in 0..<count {
        result.append(result[index]+result[index])
        result[index] = input + result[index] + input
    }
}



let k = Int(log(Double(inputN / 3)) / log(2))

for index in 0..<k {
    makeStar(value: pow(Double(2), Double(index)))
}

result.forEach { print($0) }
```
