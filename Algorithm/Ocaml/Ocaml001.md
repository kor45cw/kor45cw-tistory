# [Ocaml 문제풀이 001] Hello World!

[문제 링크](https://www.acmicpc.net/problem/2557)

## 문제

- Hello World!를 출력하시오.

## 풀이

```ocaml
let _ = 
    let msg = "Hello World!" in
    print_endline msg
```