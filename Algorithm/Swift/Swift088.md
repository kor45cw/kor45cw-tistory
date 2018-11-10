# [Swift 문제풀이 088] 선 그리기

[문제 링크](https://www.acmicpc.net/problem/16396)

## 문제

준용이의 조카 준섭이는 직선좌표에 크레파스로 여러 개의 선을 그리고 있었다.

준섭이의 모습을 보고 있던 준용이는 준섭이가 그린 모든 선들을 직선 좌표에 투사(projection)한다면, 투사된 선들의 길이 합이 궁금하였다.

준용이에게 잘 보여야하는 여러분은 준용이의 궁금증을 해결하기 위해 프로그램을 구현해주자.

## 풀이

```swift
import Foundation


var temp: Set<Int> = []

let inputN = Int(readLine() ?? "") ?? 0
for _ in 0..<inputN {
    let input = (readLine() ?? "").split {
        $0 == " "
    }.compactMap {
        Int($0)
    }

    for index in input[0]..<input[1] {
        temp.insert(index)
    }
}

print(temp.count)
```
