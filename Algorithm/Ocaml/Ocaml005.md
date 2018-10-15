# [Ocaml 문제풀이 005] 그대로 출력하기

[문제 링크](https://www.acmicpc.net/problem/11718)

## 문제

- 입력 받은 대로 출력하는 프로그램을 작성하시오.
<br><br>

## 풀이

```ocaml
let msg = read_line()

let rec printLine: string -> bool
= fun x ->
	if x = "" then false
	else let _ = (print_endline x) in
		let msg = read_line() in
			(printLine msg)

let _ =
	printLine msg
```
<br><br>

## 해설
읽은 줄의 텍스트가 ""일 경우 일때까지 recursive하게 반복되는 함수를 구성<br>
white space영역을 따로 제거하지 않은 채 프린트 하고 있으므로 보내준 값과 같은값을 출력하게 된다
<br><br><br><br>



--- 
더 좋은 풀이가 있으신 분은 댓글로 알려주세요!!