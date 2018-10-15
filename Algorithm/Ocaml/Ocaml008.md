# [Ocaml 문제풀이 008] A/B

[문제 링크](https://www.acmicpc.net/problem/1008)

## 문제

- A/B를 계산하시오.
<br><br>

## 풀이

```ocaml
let c = read_line()
let a = String.make 1 (String.get c 0)
let b = String.make 1 (String.get c 2)

let eval : int -> int -> float
=fun x y -> (float_of_int x) /. (float_of_int y)

let _ =
	print_float (eval (int_of_string a)  (int_of_string b))
```
<br><br>



--- 
더 좋은 풀이가 있으신 분은 댓글로 알려주세요!!