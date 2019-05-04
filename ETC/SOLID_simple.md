# SOLID_simple

## Single Responsibility Principle
- 단일책임 원칙은 모든 클래스는 하나의 책임만 가져야 한다는 원칙
- SRP를 지키기 위해 당장 시도해볼 수 있는 것은 클래스를 작게 만드는 것이다
- 10-200룰이란 함수는 10줄 이내, 클래스는 200줄 이내로 만드는 것이다
	- ‘함수는 10줄’ 룰을 지키려면 함수는 하나의 작업만 해야한다라는 대원칙을 지킬 수 밖에 없고 또 추상화 레벨에 대해 고민을 하게 된다.
	- ‘클래스는 200줄’ 룰을 지키려면 프로퍼티나 함수, 메서드를 그냥 손이 가는 곳 아무데나 만들어서 쓸 수 없다. 꼭 얘가 이 곳에 있어야 하는 이유를 찾아야 한다.


## Open-Closed Principle
- 확장에는 열려 있으나 변경에는 닫혀있어야 한다는 원칙
- 열려 있다는 것은 기능 추가나 변경을 할 수 있어야 한다는 것이고 닫혀있다는 것은 기능 추가를 할 때 그 모듈을 쓰고 있는 코드들을 줄줄이 수정하지 않아야 한다는 것이다.
- 즉, 하나의 enum에 대해 여러 군데에서 반복적으로 if/switch문을 쓰고 있다면 고민을 해봐야한다
- 그러면 if/switch문을 대체할 수 있는 방법 두 가지를 소개한다. 
	- 첫번째로 protocol(혹은 class)을 만들고 상속받아 쓰는 방법이다. 이 방법이 직접적으로 OCP를 지키는 구조다.
	- 두번째, 딕셔너리 활용

```swift
//적절한 곳에 딕셔너리 생성
let trackingStateMessages: [TrackingState.Reason : String] 
                         = [.initializing.        : "Move your phone".localized,
                            .excessiveMotion      : "Slow down".localized,
                            .insufficientFeatures : "Keep moving your phone".localized,
                            .relocalizing         : "Move your phone".localized]

//switch문 대체
self.instructionMessage = trackingStateMessages[reason]
```

## Liskov Subtitution Principle
- 리스코프 치환 원칙은 상위 타입(수퍼클래스)을 하위 타입(서브클래스)의 인스턴스로 바꿔도 프로그램의 동작을 해치지 않아야 한다는 원칙
- 자식이 부모의 동작을 제한해서는 안된다