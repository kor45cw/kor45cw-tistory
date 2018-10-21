#[Swift 문제풀이 022] 2007년

[문제 링크](https://www.acmicpc.net/problem/1924)

##문제

- 오늘은 2007년 1월 1일 월요일이다. 그렇다면 2007년 x월 y일은 무슨 요일일까? 이를 알아내는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let lineArr = line.split{$0 == " "}
let x = Int(lineArr[0]) ?? 0
let y = Int(lineArr[1]) ?? 0
var diffDays = 0;

for index in 1..<x {
    if [1, 3, 5, 7, 8, 10, 12].contains(index) {
        diffDays += 31
    }
    if [4, 6, 9, 11].contains(index) {
        diffDays += 30
    }

    if index == 2 {
        diffDays += 28
    }
}

diffDays += y-1

switch (diffDays % 7) {
case 0:
    print("MON")
case 1:
    print("TUE")
case 2:
    print("WED")
case 3:
    print("THU")
case 4:
    print("FRI")
case 5:
    print("SAT")
case 6:
    print("SUN")
default:
    break
}
```
