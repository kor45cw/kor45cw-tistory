#[Swift 문제풀이 011] 사칙연산

[문제 링크](https://www.acmicpc.net/problem/10869)

##문제

- 첫째 줄에 A+B, 둘째 줄에 A-B, 셋째 줄에 A*B, 넷째 줄에 A/B, 다섯째 줄에 A%B를 출력한다.

##풀이

```swift 
let line = readLine() ?? ""
let lineArr = line.split{$0 == " "}
let a = Int(lineArr[0]) ?? 0
let b = Int(lineArr[1]) ?? 0
print(a+b)
print(a-b)
print(a*b)
print(a/b)
print(a%b)
```
