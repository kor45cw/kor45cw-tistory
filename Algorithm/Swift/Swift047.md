#[Swift 문제풀이 047] 크로아티아 알파벳

[문제 링크](https://www.acmicpc.net/problem/2941)

##문제

예를 들어, ljes=njak은 크로아티아 알파벳 6개(lj, e, š, nj, a, k)로 이루어져 있다. 단어가 주어졌을 때, 몇 개의 크로아티아 알파벳으로 이루어져 있는지 출력한다.

dž는 무조건 하나의 알파벳으로 쓰이고, d와 ž가 분리된 것으로 보지 않는다. lj와 nj도 마찬가지이다. 위 목록에 없는 알파벳은 한 글자씩 센다.

##풀이

```swift 
import Foundation

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

let line = readLine() ?? ""
var index = 0
var count = 0


while index < line.count {
    let character = line[index]
    if index+1 >= line.count {
        count += 1
        index += 1
        continue
    } else if index+2 >= line.count && character == "d" && line[index+1] == "z" {
        count += 1
        index += 1
        continue
    }

    switch character {
    case "c" where line[index+1] == "=" || line[index+1] == "-",
         "d" where line[index+1] == "-",
         "l" where line[index+1] == "j",
         "n" where line[index+1] == "j",
         "s" where line[index+1] == "=",
         "z" where line[index+1] == "=":
        count += 1
        index += 2
    case "d" where line[index+1] == "z" && line[index+2] == "=":
        count += 1
        index += 3
    default:
        count += 1
        index += 1
    }
}

print(count)
```
