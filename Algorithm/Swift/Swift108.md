# [Swift 문제풀이 108] 초6 수학

[문제 링크](https://www.acmicpc.net/problem/2702)

## 문제

두 정수 a와 b 최소공배수는 두 수의 공통된 배수 중 가장 작은 수이고, 최대공약수는 두 수의 공통된 약수중 가장 큰 수이다.

a와 b가 주어졌을 때, 최소공배수와 최대공약수를 구하는 프로그램을 작성하시오.

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
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    let gcdOutput = gcd(input[0], input[1])
    let lcmOutput = lcm(input[0], input[1])
    print("\(lcmOutput) \(gcdOutput)")
}
```
