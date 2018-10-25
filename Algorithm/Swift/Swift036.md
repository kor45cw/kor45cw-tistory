#[Swift 문제풀이 036] 숫자의 개수

[문제 링크](https://www.acmicpc.net/problem/2577)

##문제

세 개의 자연수 A, B, C가 주어질 때 A×B×C를 계산한 결과에 0부터 9까지 각각의 숫자가 몇 번씩 쓰였는지를 구하는 프로그램을 작성하시오.

예를 들어 A = 150, B = 266, C = 427 이라면 

A × B × C = 150 × 266 × 427 = 17037300 이 되고, 

계산한 결과 17037300 에는 0이 3번, 1이 1번, 3이 2번, 7이 2번 쓰였다.


##풀이

```swift 
import Foundation


var array = [Int](repeating: 0, count: 10)
let a = Int(readLine() ?? "") ?? 0
let b = Int(readLine() ?? "") ?? 0
let c = Int(readLine() ?? "") ?? 0
var result = a * b * c

while result != 0 {
    let index = result % 10
    result = result / 10
    array[index] += 1
}

array.forEach { print($0) }
```
