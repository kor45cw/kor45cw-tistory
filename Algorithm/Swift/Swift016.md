#[Swift 문제풀이 016] 기찍 N

[문제 링크](https://www.acmicpc.net/problem/2742)

##문제

- 자연수 N이 주어졌을 때, N부터 1까지 한 줄에 하나씩 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0
let array = Array(1...a).reversed()

for index in array {
    print(index)
}
```
