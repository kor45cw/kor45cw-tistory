#[Swift 문제풀이 038] 음계

[문제 링크](https://www.acmicpc.net/problem/2920)

##문제

다장조는 c d e f g a b C, 총 8개 음으로 이루어져있다. 이 문제에서 8개 음은 다음과 같이 숫자로 바꾸어 표현한다. c는 1로, d는 2로, ..., C를 8로 바꾼다.

1부터 8까지 차례대로 연주한다면 ascending, 8부터 1까지 차례대로 연주한다면 descending, 둘 다 아니라면 mixed 이다.

연주한 순서가 주어졌을 때, 이것이 ascending인지, descending인지, 아니면 mixed인지 판별하는 프로그램을 작성하시오.


##풀이

```swift 

import Foundation

extension Array where Element: Comparable {
    func isSorted(by isOrderedBefore: (Element, Element) -> Bool) -> Bool {
        for i in stride(from: 1, to: self.count, by: 1) {
            if !isOrderedBefore(self[i-1], self[i]) {
                return false
            }
        }
        return true
    }
}

let input = readLine() ?? ""
let inputArr = input.split { $0 == " " }.compactMap { Int($0) }
if inputArr.isSorted(by: <) {
    print("ascending")
} else if inputArr.isSorted(by: >) {
    print("descending")
} else {
    print("mixed")
}

```
