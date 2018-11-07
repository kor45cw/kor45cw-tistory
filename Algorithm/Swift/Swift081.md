# [Swift 문제풀이 081] 최소공배수

[문제 링크](https://www.acmicpc.net/problem/1934)

## 문제

두 자연수 A와 B에 대해서, A의 배수이면서 B의 배수인 자연수를 A와 B의 공배수라고 한다. 이런 공배수 중에서 가장 작은 수를 최소공배수라고 한다. 예를 들어, 6과 15의 공배수는 30, 60, 90등이 있으며, 최소 공배수는 30이다.

두 자연수 A와 B가 주어졌을 때, A와 B의 최소공배수를 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    } else {
        if a > b {
            return gcd(a-b, b)
        } else {
            return gcd(a, b-a)
        }
    }
}

func lcm(_ m: Int, _ n: Int) -> Int {
    return m*n / gcd(m, n)
}

let input = Int(readLine() ?? "") ?? 0
for _ in 0..<input {
    let result = (readLine() ?? "")
            .split {
                $0 == " "
            }
            .compactMap {
                Int($0)
            }
    print(lcm(result[0], result[1]))
}
```
