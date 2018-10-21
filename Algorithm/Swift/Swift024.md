#[Swift 문제풀이 024] 숫자의 합

[문제 링크](https://www.acmicpc.net/problem/11720)

##문제

- N개의 숫자가 공백 없이 쓰여있다. 이 숫자를 모두 합해서 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let x = Int(line) ?? 0
let input = Array(readLine() ?? "")

var result = 0
for item in 0..<x {
    result += Int(String(input[item])) ?? 0
}

print(result)
```
