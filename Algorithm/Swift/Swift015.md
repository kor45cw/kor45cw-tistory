#[Swift 문제풀이 015] N 찍기

[문제 링크](https://www.acmicpc.net/problem/2741)

##문제

- 자연수 N이 주어졌을 때, 1부터 N까지 한 줄에 하나씩 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0

for index in 1...a {
    print(index)
}
```
