# [Swift 문제풀이 167] Yangjojang of The Year
 
[문제 링크](https://www.acmicpc.net/problem/11557)

## 문제

입학 OT때 누구보다도 남다르게 놀았던 당신은 자연스럽게 1학년 과대를 역임하게 되었다.

타교와의 조인트 엠티를 기획하려는 당신은 근처에 있는 학교 중 어느 학교가 술을 가장 많이 먹는지 궁금해졌다.

학교별로 한 해동안 술 소비량이 주어질 때, 가장 술 소비가 많은 학교 이름을 출력하여라.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for _ in 0..<input {
    let input = Int(readLine() ?? "") ?? 0
    var name = ""
    var count = 0
    for _ in 0..<input {
        let input = (readLine() ?? "").split { $0 == " " }
        if Int(input[1])! > count {
            count = Int(input[1])!
            name = String(input[0])
        }
    }
    print(name)
}
```
