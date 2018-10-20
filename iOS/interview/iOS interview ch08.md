# iOS interview ch08

##What is the Test Driven Development of three simple rules?
- 실패하는 단위 테스트를 작성할 때까지 실제 코드를 작성하지 않는다.
- 컴파일은 실패하지 않으면서 실행이 실패하는 정도로만 단위 테스트를 작성한다.
- 현재 실패하는 테스트를 통과할 정도로만 실제 코드를 작성한다.

##Please explain final keyword into the class?
- method 앞에 final을 추가함으로써 override되지 않도록 합니다.

##What is the difference open & public access level?
- open을 사용하면 다른 모듈에서 클래스를 사용하고 상속 가능
	- 맴버의 경우, 다른 모듈에서 맴버를 사용하고 재정의할 수 있습니다.
- public은 오직 다른 모듈이 public맴버와 클래스를 사용할 수 있도록 합니다.
	- public은 subclassing 할 수 없으며, 오버라이드 할 수 없다.

##What is the difference fileprivate, private and public private(set) access level ?
- 현재 파일 내에서 fileprivate에 액세스할 수 있으며, 현재 선언 내에서 private에 액세스할 수 있습니다.
- public private(set)은 getter 기능이 공용이지만 setter는 개인입니다.

##What is Internal access?
- 정의된 모듈 안에서는 사용 가능하지만 그 밖에서는 사용이 불가능하다는 선언
- internal access 는 default 접근입니다. 접근 제어 지정자를 작성하지 않으면, 기본저긍로 internal access 상태입니다.

##What is the benefit writing tests in iOS apps?
- API 설계에 대한 명확한 관점을 제공합니다.
- 좋은 테스트는 예상되는 행동에 대한 좋은 문서입니다
- 코드를 지속적으로 리팩토링 할 수 있는 자신감을 줍니다. 어떤것이 테스트에 실패하는지 알고 있기 때문입니다.

##Explain Forced Unwrapping
- 변수를 optional로 정의할 때, 이 변수에서 값을 얻어내려면 unwrap을 해야한다.
- 변수의 끝에 !를 붙이는 것을 의미

##What is bitcode?
- 비트코드는 appstore Connect에 전송되는 "LLVM 비트코드"의 유형을 나타냅니다. 
- 이를 통해 Apple은 특정 계산을 통해 앱을 추가로 다시 최적화할 수 있습니다(예: 실행 파일 크기 축소). 
- Apple에서 실행 파일을 변경해야 하는 경우 새 빌드를 업로드하지 않고도 이 작업을 수행할 수 있습니다.

##Explain Swift Standard Library Protocol?
- Swift4는 새로운 Codable 프로토콜을 도입
	- 별도로 코드를 작성하지 않고 사용자 정의 데이터 타입을 Serailize, Deserialize를 할 수 있습니다.

##What is the difference CollectionViews & TableViews?
- TableViews는 항목 목록을 단일 컬럼으로 표시하며 수직 스크롤로만 제한됩니다.
- CollectionView에는 항목 목록도 표시되지만 여러 개의 열과 행이 있을 수 있습니다.