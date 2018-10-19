#[Swift 문제풀이 013] A+B - 2

[문제 링크](https://www.acmicpc.net/problem/2558)

##문제

- 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.


##풀이

```swift 
let first = readLine() ?? ""
let second = readLine() ?? ""

let a = Int(first) ?? 0
let b = Int(second) ?? 0

print(a+b)
```
