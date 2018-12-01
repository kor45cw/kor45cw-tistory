# [Swift 문제풀이 146] 화성 수학 

[문제 링크](https://www.acmicpc.net/problem/5355)

## 문제

겨울 방학에 달에 다녀온 상근이는 여름 방학 때는 화성에 갔다 올 예정이다. (3996번) 화성에서는 지구와는 조금 다른 연산자 @, %, #을 사용한다. @는 3을 곱하고, %는 5를 더하며, #는 7을 빼는 연산자이다. 따라서, 화성에서는 수학 식의 가장 앞에 수가 하나 있고, 그 다음에는 연산자가 있다.


## 풀이

```swift
import Foundation

func check(input: String, number: Double) -> Double {
    switch input {
    case "@":
        return number * 3
    case "%":
        return number + 5
    case "#":
        return number - 7
    default:
        return number
    }
}

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }
    var first = Double(input[0])!
    for index in 0..<input.count-1 {
        first = check(input: String(input[index+1]), number: first)
    }
    print(String(format: "%.2f", first))
}
```
