#[Swift 문제풀이 012] 나머지

[문제 링크](https://www.acmicpc.net/problem/10430)

##문제

- 첫째 줄에 (A+B)%C, 둘째 줄에 (A%C + B%C)%C, 셋째 줄에 (A×B)%C, 넷째 줄에 (A%C × B%C)%C를 출력한다.


##풀이

```swift 
let line = readLine() ?? ""
let lineArr = line.split{$0 == " "}
let a = Int(lineArr[0]) ?? 0
let b = Int(lineArr[1]) ?? 0
let c = Int(lineArr[2]) ?? 0

print((a+b)%c)
print((a%c + b%c)%c)
print((a*b)%c)
print(((a%c) * (b%c))%c)
```
