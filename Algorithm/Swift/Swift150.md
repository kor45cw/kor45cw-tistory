# [Swift 문제풀이 150] 공약수 

[문제 링크](https://www.acmicpc.net/problem/5618)

## 문제

자연수 n개가 주어진다. 이 자연수의 공약수를 모두 구하는 프로그램을 작성하시오.


## 풀이

```swift
import Foundation

_ = (readLine() ?? "")
let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

for index in 1...input.min()! {
    var count = 0
    for item in input {
        if item % index != 0 {
            break
        } else {
            count += 1
        }
    }
    if count == input.count {
        print(index)
    }
}
```
