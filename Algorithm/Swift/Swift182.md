# [Swift 문제풀이 182] 피시방 알바
 
[문제 링크](https://www.acmicpc.net/problem/1453)

## 문제

세준이는 피시방에서 아르바이트를 한다. 세준이의 피시방에는 1번부터 100번까지 컴퓨터가 있다.

들어오는 손님은 모두 자기가 앉고 싶은 자리에만 앉고싶어한다. 따라서 들어오면서 번호를 말한다. 만약에 그 자리에 사람이 없으면 그 손님은 그 자리에 앉아서 컴퓨터를 할 수 있고, 사람이 있다면 거절당한다.

거절당하는 사람의 수를 출력하는 프로그램을 작성하시오. 컴퓨터는 맨 처음에 모두 비어있고, 어떤 사람이 자리에 앉으면 자리를 비우는 일은 없다.

## 풀이

```swift
import Foundation

var result = [Int](repeating: 0, count: 100)
_ = Int(readLine() ?? "") ?? 0
var count = 0
let input = (readLine() ?? "").split { $0 == " " }.compactMap { Int($0) }

    for item in input {
        if result[item-1] == 1 {
            count += 1
        } else {
            result[item-1] = 1
        }
    }


print(count)
```
