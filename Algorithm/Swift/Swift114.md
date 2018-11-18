# [Swift 문제풀이 114] 남욱이의 닭장

[문제 링크](https://www.acmicpc.net/problem/11006)

## 문제

계란집을 운영하는 남욱이는 매일 닭장에서 달걀을 수거해간다. 어느날 닭장에 들어가보니 일부 닭의 다리가 하나씩 사라졌다. 남욱이는 얼마나 많은 닭들이 한 다리를 잃었는지 알고싶었지만 닭이 너무 많아 셀 수 없었고, 대신 모든 닭의 다리수를 셌다. 고민하는 남욱이를 위해 모든 닭의 다리수의 합과 닭의 수를 가지고 이것을 해결해주자.

## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0


for _ in 0..<input {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

    let normal = input[0] - input[1]
    let abnormal = input[1] - normal
    print("\(abnormal) \(normal)")
}
```
