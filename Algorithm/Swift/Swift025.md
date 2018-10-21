#[Swift 문제풀이 025] 열 개씩 끊어 출력하기 

[문제 링크](https://www.acmicpc.net/problem/11721)

##문제

알파벳 소문자와 대문자로만 이루어진 길이가 N인 단어가 주어진다.

한 줄에 10글자씩 끊어서 출력하는 프로그램을 작성하시오.

##풀이

```swift 
let input = Array(readLine() ?? "")

for item in 0...input.count/10 {
    if (item+1)*10 > input.count {
        let items = input[(item*10)..<input.count]
        print(String(items))
    } else {
        print(String(input[(item*10)..<(item + 1) * 10]))
    }
}
```
