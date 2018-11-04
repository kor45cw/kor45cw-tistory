# intermediate ch01

- 큰 자리수의 경우 읽기 쉽게 중간에 “_”를 넣어서 끊어 줄 수 있음

```swift
let oneMillion = 1_000_000
```

- Double(1)
	- Type casting이 아니라 새로운 value를 생성하는 type conversion임


- where 절의 사용

```swift
for i in 0...100 where (i % 3) == 0 {
       NSLog("\(i)")
}
```	

- String.isEmpty : 빈 문자열이라는 것이지 값이 없다(nil)는 의미는 아님
- String의 index는 String.Index로 다룰 수 있음 (Int가 아님)

- Array index가 필요하다면? enumerate method 이용 : tuple을 반환

```swift
for (index, value) in shoppingList.enumerated() {
     print(“item \(index + 1): \(value)”)
}
```

- Hashable Protocol
	- public var hashValue: Int { get }
	- 어떤 value에 hashValue를 제공해서 value가 표현하는 값 자체의 동일성을 검증 하는데 사용
	- value의 내용을 모두 비교하는 것보다 빠르게 동작

- Capture란?
	- closure(또는 nested function) 코드 밖에서 사용되던 variable이나 constant의 값이 closure 안에서 사용될 수 있는 것
	- 외부의 값이 더 이상 존재하지 않아도 사용 가능함
	
	
- Closure(function)는 reference type 임
	- 한번 생성되어 var / let으로 대입된 것은 별도의 instance로 존재하며 다른곳에 대입되어도 reference됨
	- closure를 보관하기 때문에 retain-cycle 문제가 발생하지 않게 주의 필요 
	- compiler가 closure의 life 수명에 대해서 더 많은 정보를 받으므로 더욱 적극적인 optimizing을 하게 됨


- @autoclosures
	- parameter가 없고 return이 있는 closure를 받는 function은 그 closure를 autoclosure로 선언할 수 있음
	- autoclosure를 사용하게 선언되어있는 function을 호출 할 때는 closure 대신 간 단한 구문을 사용할 수 있음
	- 즉, @autoclosure 가 표기되어 있는 곳에 들어가는 코드는 자동으로 클로져 형식으로 한번 더 감싸져서 넘어가게 된다.
	- 간략히 정리하면 @autoclosure 는 '구문을 클로져로 알아서 감싸달라' 라는 속성이다.
	- 구문을 작성한 시점에 동작이 일어나지 않고 전달된 closure가 실행되는 시점에 동작이 일어남. 지연해서 실행할 필요가 있을 때 유용
	- 주의 : 코드의 실행이 읽는 위치에서 바로 되는 경우가 아닌데다 closure인지 인지 하지 못할 가능성이 높아 가독성을 매우 떨어트림

```swift
var names = ["Kim", "Park", "Lee"]

func updateNames(@autoclosure closure: () -> String) {
  print("Updated names array with \(closure())")
}

names
// ["Kim", "Park", "Lee"]

updateNames(names.removeFirst())

names
// ["Park", "Lee"]
```	