#[Swift 문제풀이 035] 단어의 개수

[문제 링크](https://www.acmicpc.net/problem/1152)

##문제

영어 대소문자와 띄어쓰기만으로 이루어진 문자열이 주어진다. 이 문자열에는 몇 개의 단어가 있을까? 이를 구하는 프로그램을 작성하시오.

##풀이

```swift 
import Foundation

let line = readLine() ?? ""
let lineArr = line.split { $0 == " " }.count

print(lineArr)
```
