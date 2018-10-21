#[Swift 문제풀이 020] 별찍기 - 3

[문제 링크](https://www.acmicpc.net/problem/2440)

##문제

- 첫째 줄에는 별 N개, 둘째 줄에는 별 N-1개, ..., N번째 줄에는 별 1개를 찍는 문제

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0

for index in 1...a {
    var result = ""
    for _ in 1...a-index+1 {
        result += "*"
    }
    print(result)
}
```
