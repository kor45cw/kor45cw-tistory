# [Ocaml 문제풀이 002] A+B

[문제 링크](https://www.acmicpc.net/problem/1000)

## 문제

- 두 수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
<br><br>

## 풀이

```ocaml
let c = read_line()
let a = String.make 1 (String.get c 0)
let b = String.make 1 (String.get c 2)

let eval : int -> int -> int
=fun x y -> x + y

let _ =
	print_int (eval (int_of_string(a))  (int_of_string(b)))
```
<br><br>

## 해설
Core.Str을 import하여 문제 풀이가 불가능 하기 때문에
전체라인을 String으로 읽어낸 후, 각 숫자를 Character로 형변환 한다 (1자리 숫자이므로 임의로 위치 지정 가능)
이후 각 숫자를 다시 String 으로 변환 -> 그 후에 다시 int형으로 형변환을 하도록 한다
(이유는 Character에서 int로 형변환 시 ascii 번호가 넘어오는 듯 하다)
<br><br><br><br>



--- 
더 좋은 풀이가 있으신 분은 댓글로 알려주세요!!