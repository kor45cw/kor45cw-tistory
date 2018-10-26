#[Swift 문제풀이 044] 그룹 단어 체커

[문제 링크](https://www.acmicpc.net/problem/1316)

##문제

그룹 단어란 단어에 존재하는 모든 문자에 대해서, 각 문자가 연속해서 나타나는 경우만을 말한다. 예를 들면, ccazzzzbb는 c, a, z, b가 모두 연속해서 나타나고, kin도 k, i, n이 연속해서 나타나기 때문에 그룹 단어이지만, aabbbccb는 b가 떨어져서 나타나기 때문에 그룹 단어가 아니다.

단어 N개를 입력으로 받아 그룹 단어의 개수를 출력하는 프로그램을 작성하시오.

##풀이

```swift 
import Foundation

let line = Int(readLine() ?? "") ?? 0
var count = 0


func checkIsGroup() -> Int {
    var checked: [Character] = []
    let input = readLine() ?? ""
    var before = Character("-")

    for item in input {
        if checked.contains(item) {
            return 0
        }
        if before != item {
            checked.append(before)
            before = item
        }
    }

    return 1
}

for _ in 0..<line {
    count += checkIsGroup()
}

print(count)
```
