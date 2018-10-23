#[Swift 문제풀이 028] X보다 작은 수

[문제 링크](https://www.acmicpc.net/problem/10871)

##문제

정수 N개로 이루어진 수열 A와 정수 X가 주어진다. 이때, A에서 X보다 작은 수를 모두 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let inputNumbers = readLine() ?? ""
let lineArr = line.split { $0 == " " }.compactMap { Int($0) }
let result = inputNumbers.split { $0 == " " }
        .compactMap( { Int($0) } )
        .filter { $0 < lineArr[1] }
        .reduce("") {"\($0)\($1) " }


print(result)
```
