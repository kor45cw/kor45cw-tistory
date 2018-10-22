# iOS interview ch09

##What is Alamofire doing?
- 백그라운드에서 URL을 불러오는 처리를 합니다.
- 연결 가능한 요청/응답 방법, JSON 매개변수 및 응답의 serialization, 인증 및 기타 다양한 기능을 제공
- 백그라운드에서 요청을 실행하고 main 스레드에서 completion block을 호출합니다.

##REST, HTTP, JSON — What’s that?
- HTTP는 웹 서버에서 클라이언트로 데이터를 전송하는 데 사용되는 응용프로그램 프로토콜 또는 규칙 집합입니다. 클라이언트(웹 브라우저 또는 앱)는 원하는 작업을 나타냅니다.

- REST(Representational State Transfer)는 일관성 있고 사용하기 쉽고 유지 관리가 가능한 웹 API를 설계하기 위한 규칙 집합입니다.
	- GET: 웹 페이지와 같은 데이터를 검색하는 데 사용되지만 서버의 데이터는 변경되지 않습니다.
	- HEAD: GET와 동일하지만 헤더만 다시 보내고 실제 데이터는 보내지 않습니다.
	- POST: 일반적으로 양식을 작성하고 제출을 클릭할 때 사용되는 데이터 전송에 사용됩니다.
	- PUT: 제공된 특정 위치로 데이터를 전송하는 데 사용됩니다.
	- DELETE: 제공된 특정 위치에서 데이터를 삭제합니다.

- JSON은(JavaScript Object Notation) 
	- 두 시스템 간에 데이터를 전송할 수 있는 간편한 휴대용 메커니즘을 제공합니다.

##What problems does delegation solve?
- 객체간의 coupling을 방지
- 객체의 하위 클래스를 만들 필요 없이 동작 및 수정 가능
- task가 다른 임의의 객체로 전달되도록 허용

##What is the major purposes of Frameworks?
- 코드 캡슐화/모듈화/재사용
- 다른 앱, 다른 커뮤니티와 공유할 수 있다. access제어와 결합하면 프레임워크를 통해 코드 모듈간에 강력하고 테스트 가능한 interface를 정의할 수 있다.

##What is the difference between a delegate and an NSNotification?
Delegate와 Notification을 사용하여 거의 동일한 기능을 수행 할 수 있다.

- Delegate는 1:1 
- Notification은 1:다

##What are the states of an iOS App?
- Non-running: 앱이 실행되고 있지 않습니다.
- Inactive: 앱이 화면 전면에 실행 중이지만 이벤트를 수신하지 않습니다. iOS 앱을 비활성 상태로 둘 수 있습니다(예: 통화 또는 SMS 메시지가 수신되는 경우).
- Active - 앱이 전면에서 실행되고 이벤트를 수신하고 있습니다.
- Background - 앱이 백그라운드에서 실행되고 코드가 실행됩니다.
- Suspended - 앱이 백그라운드에서 실행 중이지만 코드가 실행되지 않습니다.

##What does code signing do?
- 앱에 서명하면 iOS에서 앱에 서명한 사용자를 식별하고 앱에 서명한 이후 앱이 수정되지 않았는지 확인할 수 있습니다. 
- 서명 ID는 Apple이 우리를 위해 만든 public-private 키 쌍으로 구성됩니다.

##What is the difference between property and instance variable?
- property는 조금 더 추상적인 개념
- instance 변수는 구조체와 비슷한 저장 공간. 일반적으로 다른 객체는 절대로 직접 접근할 수 없다.
- 일반적으로 property는 인스턴스 변수를 retrun 또는 set 하지만 데이터를 사용하지않을 수도 있습니다.

##Explain difference between SDK and Framework ?
- SDK는 소프트웨어 개발 도구 모음입니다. 
- 프레임워크는 기본적으로 소프트웨어 애플리케이션을 개발하는 데 사용되는 플랫폼입니다.
- SDK와 Framework는 서로 보완하며, SDK는 프레임워크에 사용할 수 있습니다.

##What is Downcasting?
- 스위프트에는 두 가지 캐스팅 방법이 있다. 하나는 안전하며 하나는 안전하지 않다.
	- as?: safe casting, 실패할 경우 return nil
	- as!: force casting, 실패시 crash

