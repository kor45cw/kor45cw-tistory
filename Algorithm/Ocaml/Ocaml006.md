# [Ocaml 문제풀이 006] 그대로 출력하기 2

[문제 링크](https://www.acmicpc.net/problem/11719)

## 문제

- 입력 받은 대로 출력하는 프로그램을 작성하시오. (빈줄이 주어질 수 있음)
<br><br>

## 풀이

```ocaml
let msg = read_line()

let rec printLine: string -> bool
= fun x ->
	let _ = (print_endline x) in
		let msg = read_line() in
			(printLine msg)

let _ =
	printLine msg
```
<br><br>



<br><br><br><br>



--- 
더 좋은 풀이가 있으신 분은 댓글로 알려주세요!!