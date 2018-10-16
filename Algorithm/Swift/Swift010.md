#[Swift 문제풀이 010] A/B

[문제 링크](https://www.acmicpc.net/problem/1008)

##문제

- 두 정수 A와 B를 입력받은 다음, A/B를 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let lineArr = line.split{$0 == " "}
let a = Double(lineArr[0]) ?? 0.0
let b = Double(lineArr[1]) ?? 0.0
print(a/b)
```
