# [Swift 문제풀이 101] 다면체

[문제 링크](https://www.acmicpc.net/problem/10569)

## 문제

수학자가 구를 깎아서 볼록다면체를 만들었다. 이 수학자는 임의의 볼록다면체에 대해 (꼭짓점의 수) - (모서리의 수) + (면의 수) = 2가 성립한다는 것을 알고 있다. 그래서 구를 깎는 게 취미인 이 사람은 꼭짓점, 모서리와 면의 수를 기록할 때 꼭짓점과 모서리의 수만 세고 면의 수는 세지 않는다.

## 풀이

```swift
import Foundation


let inputN = Int(readLine() ?? "") ?? 0

for _ in 0..<inputN {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    let result = input[1] - input[0] + 2
    print(result)
}

```
