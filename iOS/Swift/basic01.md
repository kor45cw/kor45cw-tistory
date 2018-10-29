# Basic ch01

## 특징
1. Safe
	- optional, guard, try ~ catch, 타입 통제 등을 통한 safe programming 구현
2. Fast
	- C언어 수준의 성능을 유지하는데 초점을 맞춰 개발
3. Expressive
	- 사용하기 편하고 기존 영문법과 대응되는 문법을 구현하려 노력

## 객체지향 프로그래밍
- 여러개의 독립적 단위인 객체의 모임으로 프로그래밍을 파악하는 시각
- 각 객체는 서로 메세지를 주고 받고 데이터를 처리

- Class: 같은 종류의 집단에 속하는 속성과 행위를 정의한 것
- Object: 클래스의 인스턴스
- Message: 객체가 클래스에 정의된 행위를 실질적으로 하는 함수


## 함수형 프로그래밍
- 프로그램이 side effect 없이 데이터 처리를 수학적 함수 계산으로 취급하고자 하는 패러다임
- 대규모 병렬처리가 쉽다
- 순수하게 함수에 전달된 인자 값만 결과에 영향을 주기때문에 순수하게 함수만으로 동작
- 어떤 상황에서도 항상 같은 결과를 도출
- 상태가 변하지 않으면, 함수는 배타적으로 실행되기 떄문에 병렬처리에 문제가 거의 생기지 않는다.

- 일급 객체를 다룬다
	- Argument로 전달할 수 있다.
	- 동적 property 할당이 가능.
	- 반환값으로 사용할 수 있다.
	- 할당할 떄 사용된 이름과 관계없이 고유한 객체로 구별할 수 있다.

- 의미: 다양한 종류의 함수를 호출, 전달, 반환 하는 등의 동작으로만 프로그램을 구현할 수 있음
- 커링 기법: 여러개의 매개변수를 갖는 함수를 매개변수 하나를 갖는 함수의 나열로 표현하는 방법

## 프로토콜 지향 프로그래밍
- 참조 타입의 참조 문제에서 조금 더 자유로울 수 있고, 다중 상속이 불가능한 한계를 뛰어 넘을 수 있으며, 더 나은 추상화 메커니즘을 구현할 수 있다는 이야기