# [Swift 문제풀이 141] 조교는 새디스트야!!

[문제 링크](https://www.acmicpc.net/problem/14656)

## 문제

헌우는 제주도로 수학여행을 갔다. 들뜬 마음으로 공항을 나와 맞은 것은, 선글라스를 쓴 조교였다.

"선린인들, 아주 예의바르고 최고라고 들었는데 제가 맡았던 학교 중에서 최악입니다. 여기서 번호 순서대로 서지 않은 사람들은 전부 빠따로 맞을 각오하시기 바랍니다.“

그 말인즉슨, 자신의 번호 순대로 서지 않은 사람들은 엉덩이가 야구공이 된다는 것이다. 헌우네 반 학생 수 N이 주어지고 N명의 번호가 현재 줄 서있는 순서대로 주어질 때, 몇 명의 학생들이 맞게 될지 구하여라.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0
let inputLine = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
var count = 0

for index in 1...input {
    if inputLine[index-1] != index {
        count += 1
    }
}

print(count)
```
