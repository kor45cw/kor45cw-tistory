# [Swift 문제풀이 139] 첼시를 도와줘!

[문제 링크](https://www.acmicpc.net/problem/11098)

## 문제

구단이 성적을 내지 못한다면 답은 새 선수 영입뿐이다. 이것은 오늘날 유럽 리그에서 가장 흔한 전략이고, 노르웨이의 로젠버그 팀은 이러한 전략이 성공한 대표적 예시다. 그들은 많은 스카우터들을 지구 곳곳에 파견해 가능성 있는 루키를 찾는다.

현재 첼시는 프리미어 리그에서 헤매고 있고, 결국 새로운 선수를 사기로 결정했다. 하지만 그들은 스카우터를 기다리기 지쳤고, 훨씬 더 효율적인 전략을 개발해냈다. "만약 무언가 팔리고 있다면, 그것에는 합당한 이유가 있다"는 배룸의 명언이 바로 그것이다. 축구에서 이 말은 곧 가장 비싼 선수가 가장 좋은 선수라는 이야기가 된다. 

이에 따라 새로운 선수를 찾는 방법은 단순히 구단들에게 전화를 걸어 그들의 가장 비싼 선수를 사는게 되었다. 당신의 임무는 첼시가 리스트에서 가장 비싼 선수를 찾아낼 수 있도록 돕는 것이다.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = Int(readLine() ?? "") ?? 0
    var value = 0
    var name = ""
    for _ in 0..<input {
        let input = (readLine() ?? "").split { $0 == " " }.map { String($0) }
        if value < Int(input[0])! {
            value = Int(input[0])!
            name = input[1]
        }
    }
    print(name)
}
```
