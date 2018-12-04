# [Swift 문제풀이 179] 대표값
 
[문제 링크](https://www.acmicpc.net/problem/2592)

## 문제

열 개의 자연수가 주어질 때 이들의 평균과 최빈값을 구하는 프로그램을 작성하시오.

## 풀이

```swift
import Foundation

var dictionary = [Int: Int]()
var temp = [Int](repeating: 0, count: 10)

for index in 0..<10 {
    let input = Int(readLine() ?? "") ?? 0
    if let count = dictionary[input] {
        dictionary[input] = count+1
    } else {
        dictionary[input] = 1
    }
    temp[index] = input
}

print(temp.reduce(0, +) / 10)
print(dictionary.max { $0.value < $1.value }!.key)
```
