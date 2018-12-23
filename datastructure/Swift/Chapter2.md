# 왜 구조체인가

## 보편적으로 사용되는 자료구조에 대해 알아봅시다.

- Swift는 standard library에 클래스 대신 기능적으로 제한된 구조체를 사용한다.
- 구조체는 value type이다 -> 그것은 구조체가 하나의 소유자를 갖고, 함수로 넘겨지거나 새 변수에 할당될 때 항상 복사된다는 것을 의미한다.
- 구조체를 변경해도 어플리케이션의 다른 부분에는 영향을 미치지 않는다


## 스위프트 구조체의 몇가지 특징
1. 자동 생성되는 생성자 이외에도, 커스텀 생성자를 갖을 수 있다.
2. method를 갖을 수 있다.
3. protocol을 구현할 수 있다.

## 구조체 생성시 고려할 점
- 주된 목적은 몇가지 간단한 데이터 값을 캡슐화 시키기 위함이다
- 구조체에 의해 저장되는 모든 값들은 참조되기 보다는 복사될 것으로 예상된다
- 구조체는 다른 기존 유형의 행동 특성을 상속하지 않아도됩니다.



## Swift에서 가능한 array types
- Array
- ContiguousArray
- ArraySlice


### Array
- Array 요소 타입은 class나 @objc protocol 타입이 아니다
- Array 메모리 지역은 인접한 block에 저장된다
- Array의 요소 타입이 class나 @objc protocol 타입일때, 메모리 지역은 인접한 block (NSArray 인스턴스)이 될 수 있다.

### ContiguousArray
- Array가 구현하는 많은 프로토콜을 공유하므로 대부분의 속성이 지원됩니다.
- 핵심적인 차이는 ContiguousArray는 Objective-C와의 브릿징을 지원하지 않는다는 것이다.

### ArraySlice
- Array, ContiguousArray, 다른 ArraySlice의 부분을 나타낸다
- 요소를 저장하기 위해 인접한 메모리를 사용한다, Objective-C와 브릿징하지 않는다.
- 부작용 : 원래의 배열의 생명주기가 끝난 후에 ArraySlice를 저장하려고 시도하면 그 요소들은 더이상 접근가능하지 않다. -> 이것은 메모리 누수를 만든다.


### Array 복사 특징
- 퍼포먼스의 이유때문에, Swift는 당신이 요구한것보다 많은 요소를 할당할 것이다
- Copy-on-write : 하나이상의 배열 인스턴스가 같은 버퍼를 공유할 때는 변환 작업이 수행될 때까지 배열 요소는 복사되지 않는다.


## Dictionaries
- dictionary는 정렬되지 않은 동일한 유형의 키와 값 사이의 연관을 저장하는 정렬되지 않은 콜렉션입니다.
- dictionary 키 타입은 항상 Hashtable Protocol을 따라야한다.


## Set
- set은 정렬되지 않은 nil값이 아닌 요소들의 정렬되지 않은 유일한 콜렉션입니다.
- set 타입은 항상 Hashtable Protocol을 따라야한다. 저장하기 위해서는
- 스위프트의 기본 타입은 기본적으로 hashble이다. (Hashtable : Hashble + Equatable)


## Tuple
- tuple 타입은 콜랙션 타입이 아니다. 하지만 비슷한 특징을 갖고 있다
- tuple은 당신이 하나 또는 그 이상의 타입을 묶을 수 있도록 합니다
- SequenceType Protocol을 따르지 않는다 -> 콜렉션 타입처럼 iterate 할 수 없다.


## Subscript
- Subscript는 class, structure, enum 에 정의 가능하다.
- 콜랙션, 리스트 안의 요소에 접근하는 단축키를 제공하는 역할을 한다.


## SOLID 원칙
- oop의 5가지 기본 원칙

- 단일 책임 원칙
	- 클래스는 오직 하나의 책임을 가져야한다, 변경해야할 하나의 잠재적인 이유를 가져야한다.
- Open/Close 원칙
	- 소프트웨어 개체는 확장을 위해 열려 있어야하지만 수정을 위해 닫혀 있어야합니다.
- Liskov 치환 원칙
	- 파생 클래스는 기본 클래스로 대체 할 수 있어야합니다.
- Interface 분리 원칙
	- 많은 클라이언트 특정 인터페이스가 단수의 범용 인터페이스보다 우수합니다.
- 종속성 역변환 원칙
	- concretion에 의존하지 않고 추상화에 의존하다


## Swift Protocol-oriented Programming
- Swift 프로토콜은 메서드, 속성 및 경우에 따라 관련 형식 및 별칭 목록을 정의하며 타입 지원
- 프로토콜은 때때로 다른 언어에서 interface를 나타낸다
- 프로토콜은 하나 이상의 다른 프로토콜을 상속할 수 있다.
	
	





	