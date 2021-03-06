# Unit Test


- 단위 테스트는 낮은 수준이고 시스템의 작은 부분에만 집중한다.
- 요즘은 개발자 스스로가 편한 도구를 사용해서 스스로 단위 테스트를 작성한다
	- 차이는 그저 몇 가지 단위 테스팅 프레임워크를 사용하는 것이다. 
- 단위 테스트는 다른 종류의 테스트들에 비해서 상당히 빠르다.


- 의견의 차이는 존재
	- 무엇이 단위가 되어야 하냐는 것 (그러나 단위는 상황적인 것이다)
		- 시스템과 테스팅을 이해하기 위해 무엇이 단위가 되는 것이 합리적인지는 팀이 (그때그때)정하는 것이다.


## 고립? 통합?
- 테스트하는 단위가 통합되어야 하는지 고립되어야 하는지이다. 
	- 주문 클래스의 가격 메소드를 테스트 중이라고 상상해보라. 
	- 가격 메소드는 상품과 고객 클래스들의 어떤 함수를 실행시커야 한다. 
	- 만약 당신이 단위 테스트가 고립 되기를 바란다면, 당신은 이 테스트에서 실제 상품, 고객 클래스를 쓰고 싶지는 않을 것이다. 왜냐하면 고객 클래스에서의 실패가 주문 클래스 테스트에서의 실패로 이어질 것이기 때문이다. 대신 연관된 작업을 위한 TestDoubles을 사용한다.

- 실제로 통합된 단위 테스트를 사용하는 것은 “단위 테스팅”이라는 용어 사용에 대해 비판해왔던 이유 중에 하나였다. 
	- 테스트들이 한 개의 단위 행동만 테스트할 때만 “단위 테스팅”이라는 용어가 적절하다고 생각한다. 
	- 우리는 그 단위 이외의 모든 것들이 정확하게 동작한다고 가정하고 테스트를 작성한다.


## 속도

- 단위 테스트의 일반적인 속성들 `작은 범위, 개발자가 직접 작성할 것, 빠름` 은 프로그래밍 하는 동안 테스트가 매우 자주 실행될 것을 의미한다.
- 이런 상황에서 개발자는 어떤 코드의 변경에도 단위 테스트를 실행한다. 
- 나는 내 코드를 컴파일할 만할 때마다 1분에 몇 번 씩 단위 테스트들을 실행하기도 한다. 왜냐하면 만약 내가 (코드의) 어떤 부분을 나도 모르게 깨트렸다면, 그 즉시 알기 위해서이다. 
- 결함을 발견했을 때는 내가 방금 작성한 코드로부터 먼 곳까지 살펴볼 필요가 없기 때문에 버그를 발견하기도 훨씬 쉽다.

- 당신이 단위 테스를 매우 자주 실행한다면, 모든 단위 테스르를 전부 실행할 필요는 없을 것이다. 
- 보통은 지금 작업 중인 코드와 관련하여 작동하는 테스트들만 실행하면 된다. 
- 일반적으로는 테스트의 깊이와 테스트 모음을 실행하는데 걸리는 시간 사이에 트레이드 오프가 있다. 이 작업은 컴파일 할 때 마다 실행하는 작업이기 때문에 

- 만약 당신이 지속적 통합을 사용 중이라면, 테스트 모음을 지속적 통합의 부분으로서 실행해야 한다. 
- 내가 커밋 모음이라고 부르는 이 모음은 흔히 모든 단위 테스트들을 포함한다. 
- 어쩌면 약간의 BroadStackTests를 포함할 수도 있다. 
- 개발자는 버전 컨트롤에 커밋을 공유하기 전 뿐만 아니라 기회가 있을 때마다 `쉴 때, 회의에 참여할 때` 확실히, 하루에 몇 번 씩은 이 커밋 모음을 실행해야 한다. 커밋 모음이 빠를 수록 더 자주 실행할 수 있다.

- 중요한 점은 당신이 그 테스트 모음을 자주 실행하는데 방해되지 않을 만큼은 빠르게 돌아야 한다는 것이다. 
- 테스트 모음을 충분히 자주 실행해야 하는 이유는 테스트가 버그를 발견했을 때 충분히 빠르게 살펴볼 만큼 일의 양을 적게 만들기 위해서이다.

