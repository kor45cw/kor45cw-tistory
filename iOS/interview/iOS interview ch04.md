# iOS interview ch04


## 구조체를 쓰는 경우
* 주된 목적은 몇가지 간단한 데이터 값을 캡슐화 시키기 위함이다
* 구조체에 의해 저장되는 모든 값들은 참조되기 보다는 복사될 것으로 예상된다
	* 공유될 필요가 없는 타입
	* 레퍼런스에 기반한 자료형을 저장용 프로퍼티로 쓰지않는 타입
	* 대입보다는 생성되는 경우가 많은 타입
	

## NSError object의 구성 요소
- domain : 에러가 어떤 카테고리에서 왔는지 알려주는 구분자
- error code
- user info dictionary

## Enum?
- Enum은 기본적으로 관련된 값들의 그룹

## bounding box? 
- 기하학에서 사용되는 용어
- 주어진 점들의 집합 안에서 가장 작은 면적 or 부피를 나타냅니다.

## Why do we use synchronized?
- @synchronized
- 오직 하나의 스레드에서 실행됨을 보장할 수 있다.
- 함수를 실행 할 때 특정 구간에서 특정 자원을 접근 할 때 동시에 접근 하지 못하게 하고 싶을 때 해당 부분을 Lock 할 수 있다. 그러면 한 스레드에서 그 구간을 끝낼 때 까지 다른 스레드에서 접근 할 수 없게 된다. 이때, Deadlock 을 유의 할 것.

## Dynamic Dispatch? 
- Swift는 Dynamic Dispatch를 기본으로 하지않음 (Obj-c)
- 런타임에 호출할 메소드 또는 함수의 구현을 확인하는 방식 (not compile time)

## Code Coverage?
- 단위테스트(unit test)의 가치를 측정하는 것을 도와주는 방법중 하나

## Completion Handler? 
- API call을 만들때 유용하다.
- task가 끝난 뒤 어떤 일을 처리할 때 편리하다.
- Escape Closure

## frame 과 bounds의 차이? 
- frame: x,y 좌표와 width, height를 내가 속해있는 superview에 상대적으로 계산한 값을 보여준다.
- bounds: x,y 좌표와 width, height를 (0,0) 과 비교하여 상대적으로 계산한 값을 보여준다.
