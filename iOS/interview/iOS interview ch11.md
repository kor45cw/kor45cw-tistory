# iOS interview ch11

##What is the difference Delegates and Callbacks ?
- delegate는 NetworkService가 delegate에게 어떤 변화가 있다고 알려주는 것
- callback은 NetworkService를 관찰하여 전달하는 것

##what is Keychain ?
- Keychain은 iOS App에서 안전하게 데이터를 보존하기 위한 API입니다.

##Explain the difference between atomic and nonatomic synthesized properties
- atomic: 기본 행동입니다. 어떤 객체가 atomic 이라고 선언되면 그것은 thread-safe 해집니다. thread-safe란, 특정 시간에 오직 하나의 스레드에서 해당 클래스의 인스턴스를 컨트롤 할 수 있다는 의미입니다.

- nonatomic: Not thread-safe. nonatomic한 특성을 사용하여 다른 스레드에서 동시에 동일한 값에 엑세스 할 경우 발생하는 일에 대한 보증없이 값을 직접 설정하거나 반환하도록 지정할 수 있습니다. 이러한 이유때문에 nonatomic한 속성에 접근하는 것이 더 빠릅니다.

##What is Protocol Extensions?
- type 선언뿐 아니라 확장을 사용한 프로토콜을 채택할 수 있습니다. 
- 이렇게 하면 반드시 구현하지 않아도 되는 유형의 프로토콜을 추가할 수 있습니다.

##What is Remote Notifications attacment’s limits?
- 비디오나 이미지가 포함된 푸시알림을 보낼 수 있지만, 최대 payload는 4kb 입니다.
- 고품질 파일을 첨부하여 전송하려면 Notification Service Extension을 사용하여야 합니다.