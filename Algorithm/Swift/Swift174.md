# [Swift 문제풀이 174] 최댓값
 
[문제 링크](https://www.acmicpc.net/problem/2566)

## 문제

<그림 1>과 같이 9×9 격자판에 쓰여진 81개의 자연수가 주어질 때, 이들 중 최댓값을 찾고 그 최댓값이 몇 행 몇 열에 위치한 수인지 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

var result = (0, 0)
var value = 0

for index in 0..<9 {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    let max = input.max()!
    if value < max {
        value = max
        result = (index, input.firstIndex(of: max)!)
    }
}

print(value)
print("\(result.0+1) \(result.1+1)")
```
