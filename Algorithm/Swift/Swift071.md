# [Swift 문제풀이 071] 상근날드

[문제 링크](https://www.acmicpc.net/problem/5543)

## 문제

상근날드에서 가장 잘 팔리는 메뉴는 세트 메뉴이다. 주문할 때, 자신이 원하는 햄버거와 음료를 하나씩 골라, 세트로 구매하면, 가격의 합계에서 50원을 뺀 가격이 세트 메뉴의 가격이 된다.

햄버거는 총 3종류 상덕버거, 중덕버거, 하덕버거가 있고, 음료는 콜라와 사이다 두 종류가 있다.

햄버거와 음료의 가격이 주어졌을 때, 가장 싼 세트 메뉴의 가격을 출력하는 프로그램을 작성하시오.

## 풀이

```swift 
import Foundation

var ham: [Int] = []
for _ in 0..<3 {
    let input = Int(readLine() ?? "") ?? 0
    ham.append(input)
}

var etc: [Int] = []
for _ in 0..<2  {
    let input = Int(readLine() ?? "") ?? 0
    etc.append(input)
}

let result = (ham.min() ?? 0) + (etc.min() ?? 0) - 50

print(result)
```
