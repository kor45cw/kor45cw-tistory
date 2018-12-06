# [Swift 문제풀이 151] 콘테스트 

[문제 링크](https://www.acmicpc.net/problem/5576)

## 문제

최근 온라인에서의 프로그래밍 콘테스트가 열렸다. W 대학과 K 대학의 컴퓨터 클럽은 이전부터 라이벌 관계에있어,이 콘테스트를 이용하여 양자의 우열을 정하자라는 것이되었다.

이번이 두 대학에서 모두 10 명씩이 콘테스트에 참여했다. 긴 논의 끝에 참가한 10 명 중 득점이 높은 사람에서 3 명의 점수를 합산하여 대학의 득점으로하기로 했다.

W 대학 및 K 대학 참가자의 점수 데이터가 주어진다. 이때, 각각의 대학의 점수를 계산하는 프로그램을 작성하라.

## 풀이

```swift
import Foundation

var first: [Int] = []

for _ in 0..<10 {
    first.append(Int(readLine() ?? "") ?? 0)
}

var second: [Int] = []

for _ in 0..<10 {
    second.append(Int(readLine() ?? "") ?? 0)
}

first.sort()
first.reverse()
second.sort()
second.reverse()

print("\(first[0]+first[1]+first[2]) \(second[0]+second[1]+second[2])")
```