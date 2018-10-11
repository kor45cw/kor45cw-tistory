# iOS interview ch02


## ARC
- 참조 개수는 Class의 instance에만 해당
- 구조체와 열거형은 Value Type이라 무관

- 강한 참조 순환
    - 두 개의 클래스 인스턴스가 각각 다른 강한 참조를 가지고 있다면, 각 인스턴스는 다른 인스턴스가 살아남게 해줌.
	    - 이렇게 순환 참조가 될 경우, 둘 모두 메모리에서 해제되지 않는 문제가 발생
	    - weak 이나 unowned 선언으로 해결

    - weak 참조로 참조하고 있는 동안에 인스턴스가 메모리에서 해제될 수 있음
    - unowned 참조는 항상 값을 가지고 있는 것으로 예상되는 것
	    - unowned 참조의 값을 nil로 설정하지 않으며, unowned 참조는 옵셔널이 아닌 타입을 사용해여 정의하는 것

## GC vs. ARC
- CG 
	- 메모리 관리를 가비지 컬렉터라는 것이 프로그램 실행중에 동적으로 감시 
	- 더이상 사용할 필요가 없다고 여겨지는 것을 메모리에서 삭제해 주는 것
	- 실행타임에서 메모리 관리를 하는 것
	- 항상 메모리를 차지하고 감시해야기 때문에 프로그램 자체 외에 메모리 사용량이 더 늘어날 수 밖에 없음
	- 지속적인 감시를 위해 CPU를 일부 사용

- ARC
	- 코드를 빌드할 때에(컴파일할 때) 컴파일러가 프로그래머 대신에 release 코드를 적절한 위치에 넣어주는 것
	- 개발자가 직접 수동으로 넣을 코드를 컴파일러가 대신 하는 것이기 때문에 메모리사용량이 늘어나거나 CPU를 추가로 사용하는 오버헤드가 없음

## UIApplication state
- Active
- Inactive
- background

## Key-Value Coding (KVC)
- 정보를 의미하는 문자열(또는 키)를 사용하여 간접적으로 객체의 속성값을 접근하는 매커니즘.
- 객체의 값을 직접 가져오거나 수정하지 않고, Key 또는 Key Path 를 이용해서 간접적으로 데이터를 가져오거나 수정하는 방법을 말합니다.
	- 키가 되는 문자열은 런타임시 결정됩니다.
	- 소스 코드가 간결해지면서 유지보수도 쉬워집니다.
	- 클래스간 의존성이 낮아집니다.

	- 상대클래스를 직접 호출하는 것이 아니므로 코드 가독성이 떨어질 수 있다
	- 오타로 인해 버그로 이어질수도 있는 만큼 키-값 코딩을 남용해서는 안된다.

###Swift 에서는 KeyPath 라는 것을 이용

- Swift 3 에서 KVC 를 사용하는 방법입니다.
- `#keyPath()` 를 통해서 KVC 를 수행할 String 을 만들어줍니다.
- KVC를 사용하기 위해선 해당 인스턴스가 NSObject의 subclass여야 하고 사용하려는 property가 @objc, dynamic 속성을 가져야 합니다.

```swift
@objcMembers class Kid: NSObject {
  dynamic var nickname: String = ""
  dynamic var age: Double = 0.0
  dynamic var bestFriend: Kid? = nil
  dynamic var friends: [Kid] = []
}

let ben = Kid(nickname: "Benji", age: 5.5)

let kidsNameKeyPath = #keyPath(Kid.nickname)

let name = ben.valueForKeyPath(kidsNameKeyPath)
ben.setValue("Ben", forKeyPath: kidsNameKeyPath)
```

- Swift 4 에서는 모호함을 제거하고, 모든 시스템을 위해 KVC 를 쉽게 사용할 수 있는 방법이 도입되었습니다.

```swift
class Kid {
  var nickname: String = ""
  var age: Double = 0.0
  var bestFriend: Kid? = nil
  var friends: [Kid] = []
}

let ben = Kid(nickname: "Benji", age: 5.5)

let name = ben[keyPath: \Kid.nickname]
ben[keyPath: \Kid.nickname] = "Ben"
```

## Key Value Observing
- 특정 키의 값의 변화를 감지하기 위한 기능
- keyPath 를 사용하나 NSObject를 사용해서 사용하기 불편하다

## NSArray vs. Array 의 차이
- Array는 특정 타입의 어레이
- [AnyObject]는 클래스의 인스턴스만
- NSArray = Array<AnyObject>

## Value Type/ Reference Type 어느 메모리 영역에 저장되는가
- Reference Type : heap
- Value Type : stack

## Swift optional chaining 이란?
- 옵셔널 체이닝(Optional chaining)은 현재 옵셔널이 nil이 될 수 있는 프로퍼티, 메소드, 서브스크립트를 조회하고 호출하는 과정. 
- 옵셔널 체이닝에 값이 있으면, 프로퍼티, 메소드, 스크립트 호출은 성공합니다. 
- 옵셔널이 nil이면, 프로퍼티, 메소드, 스크립트 호출은 nil을 반환합니다. 
- 여러개를 함께 연결 할 수 있고, 연결된 어떤 링크가 nil이면, 전체 체인(chain)은 실패하게 됩니다.

```swift
yagom?.home?.guard?.job = "경비원"
```