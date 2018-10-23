# iOS interview ch10


##explain subscripts?
- Class, Structure, enum 에서 subscript를 정의할 수 있습니다.
	- 시퀀스의 구성원에 바로 접근하는 방법을 정의할 수 있습니다.

##What is DispatchGroup?
- DispatchGroup을 사용하면 작업을 전체적으로 동기화할 수 있습니다. 
	- 여러 가지 다른 작업 항목을 제출하고 완료 시 추적할 수 있습니다. 
	- 이러한 항목은 서로 다른 대기열에서 실행될 수 있습니다. 
	- 이 동작은 지정된 모든 작업이 완료될 때까지 진행하지 못할 때 유용할 수 있습니다.
- 계속하기 전에 몇 가지 비동기식 또는 동기식 작업을 기다려야 할 경우 DispatchGroup을 사용할 수 있습니다.

##Where do we use Dependency Injection?
- iOS 앱에서 스토리보드나 xib를 사용하여 IBOutlet을 만들었습니다. 
	- IBOutlet은 보기와 관련된 속성입니다. 
	- 인스턴스화되면 뷰 컨트롤러에 주입됩니다. 
	- 이는 기본적으로 종속성 주입의 한 형태입니다.
- 종속성 주입: constructor injection, property injection and method injection.


##When is a good time for dependency injection in our projects?
- 규칙 1: Testability가 중요하다면 테스트할 클래스 내에서 외부 종속성을 식별해야 합니다. 종속성이 주입되면 실제 서비스를 모의 서비스로 쉽게 대체하여 테스트를 쉽게 수행할 수 있습니다. 
- 규칙 2: 거의 모든 컨트롤러 개체와 대부분의 모델 개체를 포함하여 애플리케이션의 클래스는 대부분 복잡합니다. 가장 쉽게 시작할 수 있는 방법은 애플리케이션에서 복잡한 클래스를 선택하고 해당 클래스 내에서 다른 복잡한 개체를 초기화할 위치를 찾는 것입니다.
- 규칙 3: 개체가 다른 개체 내에서 공유 종속성이 있는 다른 개체의 인스턴스를 생성하는 경우 종속성 주입에 적합합니다.

##What kind of order functions can we use on collection types?
- map(_:): 제공된 closure를 사용해서 시퀀스의 각 요소를 변환한 후 일련의 결과를 반환
- filter(_:): 제공된 closure를 사용해서 조건을 만족하는 요소의 배열을 반환
- reduce(_:_:): 제공된 closure를 사용해서 시퀀스의 각 요소를 결합하여 단일값을 반환
- sorted(by:): 제공된 closure를 사용해서 조건을 기준으로 정렬된 요소의 배열을 반환


##What is the difference ANY and ANYOBJECT?
- Any: 모든 타입의 인스턴스를 나타낸다 (함수, optional 포함)
- AnyObject: class 타입의 인스턴스를 나타낸다.

##Could you explain Associatedtype?
- generic protocol을 만들 때 사용

##What is Hashable?
- 객체를 dictionary의 key로 사용할 수 있게 해준다.

##When do you use optional chaining vs. if let or guard?
- 작업이 실패해도 상관이 없을 때 optional chaining 사용, 그 외에는 if let 이나 guard를 사용
	- optional chaining은 optional 이 값을 갖고 있을 때만 코드 실행이 가능하다.
	- value?.type 이처럼 ? 연산자를 사용하는 것을 optional chaining 이라고 한다.


##Explain to using Class and Inheritance benefits
- 모듈화
- 재사용 구현
- subclass는 dynamic dispatch를 제공
- subclassing을 통해 reuse interface 제공
- override를 통해서 매커니즘을 커스텀화 할수 있게 제공
