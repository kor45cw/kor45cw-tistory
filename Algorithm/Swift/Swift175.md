# [Swift 문제풀이 175] Hello Judge
 
[문제 링크](https://www.acmicpc.net/problem/9316)

## 문제

당신은 N개의 테스트케이스들에게 반드시 인사를 해야 이 문제를 풀 수 있다.

N개의 줄에 걸쳐

"Hello World, Judge i!"

를 출력하는 프로그램을 만들라. 여기서 i는 줄의 번호이다.


## 풀이

```swift
import Foundation

let input = Int(readLine() ?? "") ?? 0

for index in 1...input {
    print("Hello World, Judge \(index)!")
}
```
