#[Swift 문제풀이 023] 합

[문제 링크](https://www.acmicpc.net/problem/8393)

##문제

- n이 주어졌을 때, 1부터 n까지 합을 구하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let x = Int(line) ?? 0

print(Array(1...x).reduce(0, +))
```
