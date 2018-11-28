# [Swift 문제풀이 130] 분수좋아해?

[문제 링크](https://www.acmicpc.net/problem/10474)

## 문제

당신은 학생들의 기초수학 학습을 돕는 소프트웨어를 개발하는 팀의 개발자이다. 당신은 가분수를 대분수(?)로 출력하는 부분을 개발해야 한다. 진분수는 분자가 분모보다 작은 분수이다; 대분수는 정수부를 따로 떼어주고 남는 부분을 진분수로 쓰는 기법이다. 예제로, 27/12는 대분수로 2 3/12이다. 기약분수로 만들지 말아야 한다.(3/12를 1/4로 바꿔 출력하지 마시오.)

## 풀이

```swift
import Foundation


while true {
    let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }
    if input[0] == 0 && input[1] == 0 { break }
    print("\(input[0] / input[1]) \(input[0] % input[1]) / \(input[1])")
}
```
