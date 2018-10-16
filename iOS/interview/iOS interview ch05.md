# iOS interview ch05

##What is Responder Chain?
- 수신된 이벤트의 반응할 기회가 있는 object의 계층입니다.
	- UIControl Actions, User Events, System Events

##What is Regular expressions?
- 사전적인 의미로는 특정한 규칙을 가진 문자열의 집합을 표현하는데 사용하는 형식 언어입니다.

##What is Functions?
- 일련의 문장을 그룹화 하여 작업을 수행할 수 있게 하는 것
- 코드의 반복을 제거하는 훌륭한 해답중 하나
	- 잘못된 함수는 전역변수를 설정하고 다른 함수에 의존하여 작동

##What is ABI(Application Binary Interface)?
- 응용프로그램과 운영체제 또는 응용프로그램과 해당 라이브러리, 마지막으로 응용프로그램의 구성요소 간에서 사용되는 낮은 수준의 인터페이스
- 특정 라이브러리를 사용하도록 프로그램이 만들어지고 나중에 해당 라이브러리가 업데이트되면 해당 응용 프로그램을 다시 컴파일할 필요가 없습니다(최종 사용자의 관점에서 볼 때 소스가 없을 수도 있음). 업데이트된 라이브러리에서 동일한 ABI를 사용하는 경우 프로그램을 변경할 필요가 없습니다. 

##Why is design pattern very important? 
- 일반적인 문제에 대한 재사용 가능한 솔루션, 이해하기 쉽고 재사용할 수 있는 코드를 작성할 수 있도록 설계된 템플릿
- Most common Cocoa design patterns:
	- Creational: Singleton.
	- Structural: Decorator, Adapter, Facade.
	- Behavioral: Observer, and, Memento


##What is Singleton Pattern?
- 특정 클래스에 대해 하나의 인스턴스만 존재하고 해당 인스턴스에 대한 global 접근 지점이 있음을 보장
- 보통 lazy로 선언하여 단일 인스턴스를 생성합니다.

##What is Facade Design Pattern?
- 복잡한 서브시스템에 대한 단일한 인터페이스를 제공
- 사용자를 클래스 및 해당 API에 노출하는 대신 하나의 간단한 통일된 API를 노출하는 것

##What is Decorator Design Pattern?
- 코드를 수정하지 않고 개체에 동작과 책임을 동적으로 추가합니다.
- 클래스의 동작을 다른 개체와 함께 묶어서 수정하는 하위 클래스 지정 대신 사용할 수 있습니다.

##What is Adapter Pattern?
- 호환되지 않는 인터페이스를 가진 클래스가 함께 작동할 수 있다
- 개체를 감싸고 해당 object와 상호작용하기 위한 표준 인터페이스를 표시합니다.

##What is Observer Pattern?
- object 하나는 다른 객체에 상태 변경을 알립니다.
- notification과 KVO로 구현 가능합니다.

##What is Memento Pattern?
- 데이터를 어딘가에 저장
- 나중에 이 상태를 캡슐화를 위반하지 않고 복원