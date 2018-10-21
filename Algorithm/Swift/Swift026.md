#[Swift 문제풀이 026] 시험 성적

[문제 링크](https://www.acmicpc.net/problem/9498)

##문제

시험 점수를 입력받아 90 ~ 100점은 A, 80 ~ 89점은 B, 70 ~ 79점은 C, 60 ~ 69점은 D, 나머지 점수는 F를 출력하는 프로그램을 작성하시오.


##풀이

```swift 
let line = readLine() ?? ""
let score = Int(line) ?? 0

switch score {
case 90...100:
    print("A")
case 80..<90:
    print("B")
case 70..<80:
    print("C")
case 60..<70:
    print("D")
default:
    print("F")
}
```
