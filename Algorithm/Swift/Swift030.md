#[Swift 문제풀이 030] 평균은 넘겠지

[문제 링크](https://www.acmicpc.net/problem/4344)

##문제

대학생 새내기들의 90%는 자신이 반에서 평균은 넘는다고 생각한다. 당신은 그들에게 슬픈 진실을 알려줘야 한다.

첫째 줄에는 테스트 케이스의 개수 C가 주어진다.

둘째 줄부터 각 테스트 케이스마다 학생의 수 N(1 ≤ N ≤ 1000, N은 정수)이 첫 수로 주어지고, 이어서 N명의 점수가 주어진다. 점수는 0보다 크거나 같고, 100보다 작거나 같은 정수이다.

##풀이

```swift 
import Foundation

let inputC = Int(readLine() ?? "") ?? 0

for _ in 0..<inputC {
    var inputNumbers = (readLine() ?? "").split { $0 == " " }.compactMap { Double($0) }
    let count = inputNumbers.removeFirst()
    let avg = inputNumbers.reduce(0, +) / count
    let largeCount = Double(inputNumbers.filter { $0 > avg }.count)
    let result = String(format: "%.3f", (largeCount / count) * 100.0)
    print("\(result)%")
}
```
