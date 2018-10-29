# Basic ch02

- 콘솔로그
  - print\(\), dump\(\)
- 주석
  - [use markup method](https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/)

## Data Type
- 기본 데이터 타입은 모두 구조체를 기반으로 구현되어있다.
- UInt: Unsigned Int 
	- Int 범위를 넘어갈 때만 쓰는게 좋다. 
	- 음수 변환시 많은 cost가 발생
- Any: 모든 데이터타입
- AnyObject: 클래스의 인스턴스만 할당 가능

- Value Type의 데이터교환은 엄밀히 말하면 Type casting이 아니라 새로운 인스턴스를 생성하여 할당 하는 것
- 컴파일시 타입을 결정: 타입추론
- typealias Person = \(name: String, age: Int\)
- Collection Type: 배열, 딕셔너리, Set

- enum
	- 프로그래머가 정의해준 값 이외에는 추가/수정이 불가능한 타입
	- 제한된 선택지
	- 정해진 값 외에는 입력받고 싶지 않을 때
	- 예상된 입력값이 한정되어있을 때

	- 연관값
		- enum 내의 항목이 자신과 연관된 값을 갖을 수 있음
	- 순환 열거형
		- 연관값이 자신의 값이고자 할 때 사용: indirect 키워드 사용
	
```swift
enum MainDish {
    case pasta(taste: String)
}
```


## 연산자

```swift
// 전위 연산자 구현과 사용
prefix operator **

prefix func **(value: Int) -> Int {
    return value * value
}

// 후위 연산자 구현과 사용
postfix operator **

postfix func **(value: Int) -> Int {
    return value + 10
}

// 중위 연산자 구현과 사용
// 우선순위 그룹을 명시해야 (그렇지 않으면 가장 높은 그룹으로 자동 설정)
precedencegroup 우선순위 그룹 이름 {
    higherThan: 더 낮은 우선순위 그룹 이름
    lowerThan: 더 높은 우선순위 그룹 이름
    associativity: 결합방법 (left/right/none)
    assignment: 할당방향 사용 (true/false)
}

infix operator **: MultiplicationPrecedence

func **(lhs: String, rhs: String) -> Bool {
    return lhs.contain(rhs)
}
```