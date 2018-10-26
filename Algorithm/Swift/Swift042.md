#[Swift 문제풀이 042] 문자열 반복 

[문제 링크](https://www.acmicpc.net/problem/2675)

##문제

문자열 S를 입력받은 후에, 각 문자를 R번 반복해 새 문자열 P를 만든 후 출력하는 프로그램을 작성하시오. 즉, 첫 번째 문자를 R번 반복하고, 두 번째 문자를 R번 반복하는 식으로 P를 만들면 된다. S에는 QR Code "alphanumeric" 문자만 들어있다.

QR Code "alphanumeric" 문자는 `0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\$%*+-./:` 이다.

##풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0

for _ in 0..<line {
    let input = readLine() ?? ""
    let inputArr = input.split { $0 == " " }
    let inputP = Int(inputArr[0]) ?? 0
    var temp = ""
    for character in inputArr[1] {
        for _ in 0..<inputP {
            temp += String(character)
        }
    }
    print(temp)
}
```
