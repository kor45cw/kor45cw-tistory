#[Swift 문제풀이 002] A+B

[문제 링크](https://www.acmicpc.net/problem/1000)

##문제

- 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let line = readLine() ?? ""
let lineArr = line.characters.split{$0 == " "}.map(String.init)
let a = Int(lineArr[0]) ?? 0
let b = Int(lineArr[1]) ?? 0
print(a+b)
```

### 궁금증

```swift
func solution() {
    let line = readLine()
    guard let read = line else { return }
    let result = read.components(separatedBy: " ").compactMap({ Int($0) }).reduce(0, +)
    print(result)
}

solution()
```

다음과 같은 코드로 제출 했었는데 

Main.swift:4:18: error: value of type 'String' has no member 'components'

이런 컴파일 에러를 마주할 수 있었다. AppCode와 Xcode 에서는 정상 작동하는 코드인것을 확인하였다.