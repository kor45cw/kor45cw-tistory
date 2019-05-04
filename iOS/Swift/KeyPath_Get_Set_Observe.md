# KeyPath의 Get Set 그리고 Observe

```swift
struct A {
	var b: Int = 0
}

var a = A()
a[keyPath: \A.b] = 10
print(a.b) // Output 10
print(a[keyPath: \A.b]) // Output 10
```

- 또한 KeyPath는 Observe도 제공
- 타입이 클래스이며, NSObject를 상속받아야
- 관측할 속성은 @objc dynamic 키워드를 추가

```swift
class A: NSObject {
    @objc dynamic var b = 0
}

@objcMembers class A: NSObject {
    dynamic var b = 0
}
```