#[Swift 문제풀이 033] 한수

[문제 링크](https://www.acmicpc.net/problem/1065)

##문제

어떤 양의 정수 X의 자리수가 등차수열을 이룬다면, 그 수를 한수라고 한다. 등차수열은 연속된 두 개의 수의 차이가 일정한 수열을 말한다. N이 주어졌을 때, 1보다 크거나 같고, N보다 작거나 같은 한수의 개수를 출력하는 프로그램을 작성하시오. 

##풀이

```swift 
let inputN = Int(readLine() ?? "") ?? 0
var count = 0

for item in 1...inputN {
    if item < 100 { count += 1; continue; }

    if (item / 100 - (item % 100) / 10 == (item % 100) / 10 - item % 10) {
        count += 1
    }
}

print(count)
```
