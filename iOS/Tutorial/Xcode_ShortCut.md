# Xcode Shortcut

##기본적인 에디팅에 관련된 것들

- Option + Left or Right
	- 단어 단위로 커서를 이동합니다.
- Command + Left or Right
	- 줄의 맨 앞/뒤로 커서를 이동합니다.
- Command + ] or [
	- 현재 선택된 블럭의 코드를 한 탭만큼 들여쓰기 내여쓰기를 합니다.
-  Option + Tab
	- Tab이 공백문자로 치환되도록 설정되어 있더라도 강제로 Tab을 입력합니다.
- Command + L
	- 특정 라인 위치로 이동합니다.
- ESC
	- 자동 완성 가능한 후보 목록을 보여줍니다.
- Option + delete
	- 단어 단위로 삭제하기.
- Command + delete
	- 전체 줄 삭제하기. (Command + Right 후 Command + delete하면 전체 줄이 삭제 됨)
- Command + R
	- 현재 입력한 내용을 Shell command로 실행하여 결과를 하단에 출력하기.


## 소스 코드 분석을 위한 기능들

- `#pragma mark MARK STRING HERE`
	- 에디터 상단의 Function Menu에 원하는 문자열을 출력할 수 있습니다.
- `#pragma mark -`
	- Function Menu에 구분줄을 표시할 수 있습니다.
- `// TODO: Implement this later time ..`
	- Funtion Menu에 TODO 문자열 항목을 추가할 수 있습니다. 
	- 이 외에도 FIXME:, !!!:, ???:와 같은 문자로 시작하는 주석문은 Funtion Menu에 항목으로 추가됩니다.
- Option + double click
	- 해당 항목에 대한 문서를 보여줍니다.

- Command + \ 
	- 브래크포인트 걸기/해제하기
- Command + b 
	- 빌드
- Command + shift + o 
	- 스탭인 (한줄 실행:해당함수의 내부로 점프하진 않습니다)

- option+cmd+왼키/오른키/위키 소스 파일 전환, m<->h 전환
- option+cmd+shift+t 현재 소스 파일에 대한 워크스페이스 트리 노드 선택 --;

##에디터창
- 에디터전체보기/취소 : Shift + comm + E
- 헬프창열기 : Shift + comm + /
- 전체찾기 : Shift + comm + F (vc에서 find in files)
- 다음문자 : Comm + G
- 페이지업/다운 : fn + 위/아래 화살표키
- 우측으로들여쓰기: comm + ]
- 좌측으로들여쓰기: comm + [

##빌드
- 빌드 후 실행 : comm + R
- 빌드 후 디버그 : comm + Y or comm + enter

##디버깅
- 다음 경고/오류보기 : comm + =
- 디버거로이동 : shift + comm + y
- 디버그실행 : option + comm + Y
- step into : shift + comm + I
- step over : shift + comm + O
- Ctrl + / : 다음 파라미터로 가기
- command + / : //주석 단축키 