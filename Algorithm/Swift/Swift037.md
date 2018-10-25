#[Swift 문제풀이 037] OX퀴즈

[문제 링크](https://www.acmicpc.net/problem/8958)

##문제

"OOXXOXXOOO"와 같은 OX퀴즈의 결과가 있다. O는 문제를 맞은 것이고, X는 문제를 틀린 것이다. 문제를 맞은 경우 그 문제의 점수는 그 문제까지 연속된 O의 개수가 된다. 예를 들어, 10번 문제의 점수는 3이 된다.

"OOXXOXXOOO"의 점수는 1+2+0+0+1+0+0+1+2+3 = 10점이다.

OX퀴즈의 결과가 주어졌을 때, 점수를 구하는 프로그램을 작성하시오.


##풀이

```swift 

import Foundation

func fibo(_ n: Int) -> Int {
    if n == 1 { return 1 }
    return fibo(n-1)+n
}

let inputN = Int(readLine() ?? "") ?? 0

for _ in 0..<inputN {
    let line = readLine() ?? ""
    print(line.split{ $0 == "X" }.compactMap { fibo($0.count) }.reduce(0, +))
}

```
