#[Swift 문제풀이 049] 분수찾기

[문제 링크](https://www.acmicpc.net/problem/1193)

##문제

이와 같이 나열된 분수들을 1/1 -> 1/2 -> 2/1 -> 3/1 -> 2/2 -> … 과 같은 지그재그 순서로 차례대로 1번, 2번, 3번, 4번, 5번, … 분수라고 하자.

X가 주어졌을 때, X번째 분수를 구하는 프로그램을 작성하시오.

##풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0
var sum = 0
var count = 0

// 1 -> 합이 2
// 2,3 -> 합이 3
// 4,5,6 -> 합이 4
// 7,8,9,10 -> 합이 5

while true {
    count += 1
    sum += count

    if sum >= line {
        break
    }
}

// 짝수는 위가 더 큰것부터 시작
// 홀수는 아래가 더 큰것부터 시작

var top = ((count+1) % 2 == 0) ? count : 1
var bottom = ((count+1) % 2 == 0) ? 1 : count


for _ in sum-count+1..<line {
    if (count+1) % 2 == 0 {
        top += -1
        bottom += 1
    } else {
        top += 1
        bottom += -1
    }
}

print("\(top)/\(bottom)")
```
