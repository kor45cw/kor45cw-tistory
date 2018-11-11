# [Swift 문제풀이 099] 맞았는데 왜 틀리죠?

[문제 링크](https://www.acmicpc.net/problem/15820)

## 문제

첫 줄에 샘플 테스트케이스의 개수 S1과 시스템 테스트케이스의 개수 S2가 주어진다. 

두 번째 줄부터 S1개의 줄에는 차례로 각 샘플 테스트케이스의 정답과 만영이의 코드가 생성한 답이 공백으로 구분되어 주어진다. 이후 S2개의 줄에 걸쳐 차례로 각 시스템 테스트케이스의 정답과 만영이의 코드가 생성한 답이 공백으로 구분되어 주어진다.

모든 테스트케이스의 정답과 만영이의 코드가 생성한 답은 -231 이상 231-1 이하의 정수이다.

## 풀이

```swift
import Foundation


var haveResult = false
let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

for _ in 0..<input[0] {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    if input[0] != input[1] {
        haveResult = true
        print("Wrong Answer")
        break
    }
}

if !haveResult {
    for _ in 0..<input[1] {
        let input = (readLine() ?? "").split {
            $0 == " "
        }.compactMap {
            Int($0)
        }
        if input[0] != input[1] {
            haveResult = true
            print("Why Wrong!!!")
            break
        }
    }
}

if !haveResult {
    print("Accepted")
}
```
