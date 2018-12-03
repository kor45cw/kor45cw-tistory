# [Swift 문제풀이 162] 앵그리 창영
 
[문제 링크](https://www.acmicpc.net/problem/3034)

## 문제

창영이는 화가나서 성냥을 바닥에 던졌다.

상근이는 바닥이 더러워진 것을 보고 창영이를 매우 혼냈다.

강산이는 근처에서 박스를 발견했다.

상덕이는 강산이가 발견한 박스를 상근이에게 주었다.

상근이는 박스에 던진 성냥을 모두 담아오라고 시켰다.

하지만, 박스에 들어가지 않는 성냥도 있다.

이런 성냥은 박스에 담지 않고 희원이에게 줄 것이다.

성냥이 박스에 들어가려면, 박스의 밑면에 성냥이 모두 닿아야 한다.

박스의 크기와 성냥의 길이가 주어졌을 때, 성냥이 박스에 들어갈 수 있는지 없는지를 구하는 프로그램을 작성하시오. 창영이는 성냥을 하나씩 검사한다.

## 풀이

```swift
import Foundation

let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
let maxValue = Double(input[1] * input[1] + input[2] * input[2]).squareRoot()

for _ in 0..<input[0] {
    let input = Double(readLine() ?? "") ?? 0.0
    if input > maxValue {
        print("NE")
    } else {
        print("DA")
    }
}

```
