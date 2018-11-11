# [Swift 문제풀이 097] 링

[문제 링크](https://www.acmicpc.net/problem/3036)

## 문제

상근이는 창고에서 링 N개를 발견했다. 상근이는 각각의 링이 앞에 있는 링과 뒤에 있는 링과 접하도록 바닥에 내려놓았다. 

상근이는 첫 번째 링을 돌리기 시작했고, 나머지 링도 같이 돌아간다는 사실을 발견했다. 나머지 링은 첫 번째 링 보다 빠르게 돌아가기도 했고, 느리게 돌아가기도 했다. 이렇게 링을 돌리다 보니 첫 번째 링을 한 바퀴 돌리면, 나머지 링은 몇 바퀴 도는지 궁금해졌다.

링의 반지름이 주어진다. 이때, 첫 번째 링을 한 바퀴 돌리면, 나머지 링은 몇 바퀴 돌아가는지 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

func gcd(_ a: Int, _ b: Int) -> Int { if b == 0 { return a } else { if a > b { return gcd(a-b, b) } else { return gcd(a, b-a) } } }

let input = Int(readLine() ?? "") ?? 0
let temp = (readLine() ?? "").split {
        $0 == " "
    }.compactMap {
        Int($0)
    }

for index in 1..<input {
    let gcdResult = gcd(temp[0], temp[index])
    print("\(temp[0] / gcdResult)/\(temp[index]/gcdResult)")
}
```
