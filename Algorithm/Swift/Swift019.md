#[Swift 문제풀이 019] 별찍기 - 2

[문제 링크](https://www.acmicpc.net/problem/2439)

##문제

- 첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제. 하지만, 오른쪽을 기준으로 정렬한 별 (예제 참고)을 출력하시오.

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0

for index in 1...a {
    var result = ""
    for _ in 1..<a-index+1 {
        result += " "
    }
    for _ in a-index+1...a {
        result += "*"
    }
    print(result)
}
```
