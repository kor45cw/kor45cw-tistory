# [Swift 문제풀이 082] 최대공약수와 최소공배수

[문제 링크](https://www.acmicpc.net/problem/2609)

## 문제

두 개의 자연수를 입력받아 최대 공약수와 최소 공배수를 출력하는 프로그램을 작성하시오.


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


let result = (readLine() ?? "")
        .split {$0 == " " }
        .compactMap { Int($0) }

print(gcd(result[0], result[1]))
print(lcm(result[0], result[1]))
```
