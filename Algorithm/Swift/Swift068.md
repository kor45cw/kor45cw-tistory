# [Swift 문제풀이 068] 곱셈

[문제 링크](https://www.acmicpc.net/problem/2588)

## 문제

(세 자리 수) × (세 자리 수)는 다음과 같은 과정을 통하여 이루어진다.

(1)과 (2)위치에 들어갈 세 자리 자연수가 주어질 때 (3), (4), (5), (6)위치에 들어갈 값을 구하는 프로그램을 작성하시오.


## 풀이

```swift 
import Foundation


let first = Int(readLine() ?? "") ?? 0
let second = Int(readLine() ?? "") ?? 0

print(first * (second % 10))
print(first * ((second / 10) % 10))
print(first * (second / 100))
print(first * second)
```
