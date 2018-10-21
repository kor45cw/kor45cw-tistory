#[Swift 문제풀이 017] 구구단

[문제 링크](https://www.acmicpc.net/problem/2739)

##문제

- N을 입력받은 뒤, 구구단 N단을 출력하는 프로그램을 작성하시오. 출력 형식에 맞춰서 출력하면 된다.

##풀이

```swift 
let line = readLine() ?? ""
let a = Int(line) ?? 0
let array = Array(1...9)

for index in array {
    print("\(a) * \(index) = \(a * index)")
}
```
