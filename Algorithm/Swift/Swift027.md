#[Swift 문제풀이 027] 세 수

[문제 링크](https://www.acmicpc.net/problem/10817)

##문제

세 정수 A, B, C가 주어진다. 이때, 두 번째로 큰 정수를 출력하는 프로그램을 작성하시오. 

##풀이

```swift 
import Foundation

let line = readLine() ?? ""
let lineArr = line.split { $0 == " " }


let a = Int(lineArr[0]) ?? 0
let b = Int(lineArr[1]) ?? 0
let c = Int(lineArr[2]) ?? 0

let type = (a > b)
        ? ((a > c) ? ((b > c) ? b : c) : a)
        : ((b > c) ? ((a > c) ? a : c) : b);

print(type)
```
