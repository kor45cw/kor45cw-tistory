# [Swift 문제풀이 145] 팬들에게 둘러싸인 홍준

[문제 링크](https://www.acmicpc.net/problem/14581)

## 문제

홍준은 참 팬이 많다. 이를 본 구사과는 BOJ 슬랙에서 이모티콘을 만들었다.

선풍기 모양의 이모티콘은 :fan: 이고, 홍준의 이모티콘은 :(홍준의 아이디): 이다. 홍준의 아이디가 주어지면 구사과가 만든 이모티콘을 출력하는 프로그램을 작성하여라. 자세한 출력 방식은 입출력 형식을 참고하면 된다.


## 풀이

```swift
print(":fan::fan::fan:\n:fan::\((readLine() ?? ""))::fan:\n:fan::fan::fan:")
```