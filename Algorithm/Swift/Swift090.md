# [Swift 문제풀이 090] 히스토그램

[문제 링크](https://www.acmicpc.net/problem/13752)

## 문제

히스토그램은 데이터를 시각적으로 표현한 것이다. 막대로 구성되며 각 막대의 길이는 데이터 양의 크기를 나타낸다. 일부 데이터가 주어지면 히스토그램을 생성하시오.


## 풀이

```swift
import Foundation


let inputN = Int(readLine() ?? "") ?? 0

for _ in 0..<inputN {
    let inputA = Int(readLine() ?? "") ?? 0
    var temp = ""
    for _ in 0..<inputA {
        temp += "="
    }
    print(temp)
}
```
