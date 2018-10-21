#[Swift 문제풀이 018] 별찍기 - 1

[문제 링크](https://www.acmicpc.net/problem/2438)

##문제

- 첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0

for index in 1...a {
    var result = ""
    for _ in a-index+1...a {
        result += "*"
    }
    print(result)
}
```
