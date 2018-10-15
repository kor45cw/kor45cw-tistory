# [Ocaml 문제풀이 007] A*B

[문제 링크](https://www.acmicpc.net/problem/10998)

## 문제

- 두 수 A와 B를 입력받은 다음, A*B를 출력하는 프로그램을 작성하시오.
<br><br>

## 풀이

```ocaml
let c = read_line()
let a = String.make 1 (String.get c 0)
let b = String.make 1 (String.get c 2)

let eval : int -> int -> int
=fun x y -> x * y

let _ =
	print_int (eval (int_of_string(a))  (int_of_string(b)))
```
<br><br>



--- 
더 좋은 풀이가 있으신 분은 댓글로 알려주세요!!