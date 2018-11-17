# [Swift 문제풀이 109] 아이들은 사탕을 좋아해

[문제 링크](https://www.acmicpc.net/problem/9550)

## 문제

승택이의 아들이 생일을 맞았다. 승택이는 아들을 위해 생일 파티를 하려고 한다.

하지만 아들의 친구들을 모두 초대할 수는 없다. 아이들에게 나눠 줄 사탕이 부족하기 때문이다.

아이들은 항상 한 종류의 사탕만을 먹고 싶어한다. 게다가, 한 종류의 사탕을 최소한 K개 이상 먹어야만 행복해한다.

K가 주어지고 승택이가 현재 갖고 있는 사탕의 종류와 개수가 주어진다. 이때, 생일파티에 올 수 있는 아이들은 최대 몇 명일까?

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let inputFirst = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    let inputSecond = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    print(inputSecond.map { $0 / inputFirst[1] }.reduce(0, +))
}
```
