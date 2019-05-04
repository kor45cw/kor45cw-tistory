# Swift5

## Raw String
- Swift 4.2 uses escape sequences to represent backslashes and quote marks in strings:

```swift
let escape = "You use escape sequences for \"quotes\"\\\"backslashes\" in Swift 4.2."
let multiline = """
                You use escape sequences for \"\"\"quotes\"\"\"\\\"\"\"backslashes\"\"\"
                on multiple lines
                in Swift 4.2.
                """
```

- Swift 5 adds raw strings. You add # at the beginning and end of the string so you can use backslashes and quote marks without issue.

```swift
let raw = #"You can create "raw"\"plain" strings in Swift 5."#
let multiline = #"""
                You can create """raw"""\"""plain""" strings
                on multiple lines
                in Swift 5.
                """#

let track = "Nothing Else Matters"
print(#"My favorite tune\song is \#(track)."#)
```

- No extra backslashes in regular expressions!

```swift
let regex = try! NSRegularExpression(pattern: #"\d\.\d"#)
```

## Using New Character Properties
```swift
id.forEach { digits += $0.isNumber ? 1 : 0 }
```


## Result Type
- success 와 failure 로 구성
- failure은 반드시 Error 타입과 함께 사용하여야 함

```swift
Result<Int, NetworkError>
-> .failure(.badURL)
-> .success(5)
```

- result.get() 함수가 있음
	- 성공한 값이 있을 경우 해당 값을 가져오는 method

- result는 이니셜라이져로 클로져를 받을 수 있다
	- 해당 클로져가 정상적으로 값을 반환한다면, success
	- 값이 없다면, failure	

- map(), flatMap(), mapError(), flatMapError()를 갖고 있음

## Customizing string interpolation
- `String.StringInterpolation`에 `appendInterpolation()` 메소드가 새로 추가

```swift
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: User) {
        appendInterpolation("My name is \(value.name) and I'm \(value.age)")
    }
}

 let user = User(name: "Guybrush Threepwood", age: 33)
 print("User details: \(user)")
 
 
 extension String.StringInterpolation {
    mutating func appendInterpolation(_ number: Int, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style

        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
}
 let number = Int.random(in: 0...100)
 let lucky = "The lucky number this week is \(number, style: .spellOut)."
 print(lucky)
``` 
	

##@dynamicCallable 
- 간단한 구문 sugar를 사용하여 함수를 호출하는 것처럼 명명된 형식을 호출 할 수 있게 해줍니다.

```swift
@dynamicCallable 
struct ToyCallable {
    func dynamicallyCall(withArguments: [Int]) {}
    func dynamicallyCall(withKeywordArguments: KeyValuePairs<String, Int>) {}
}

let x = ToyCallable()

x(1, 2, 3)
// x.dynamicallyCall(withArguments: [1, 2, 3])

x(label: 1, 2)
// x.dynamicallyCall(withKeywordArguments: ["label": 1, "": 2])
```

- You can apply it to structs, enums, classes, and protocols.
- If you implement withKeywordArguments: and don’t implement withArguments:, your type can still be called without parameter labels – you’ll just get empty strings for the keys.
- If your implementations of withKeywordArguments: or withArguments: are marked as throwing, calling the type will also be throwing.
- You can’t add @dynamicCallable to an extension, only the primary definition of a type.
- You can still add other methods and properties to your type, and use them as normal.

## Handling future enum cases
- enum switch 중에 exhaustive 하지않은 케이스 추가
	- 원래는 모든 케이스를 다 돌았다면 워닝 안뜸
	- 이제는 뜸 -> `@unknown default` 를 추가해야 안뜸 -> 미래에 바뀔지 모르는 것에 대비 (ex> iOS Size Class 가  추후 어떤게 추가될지 모름 default가 없다면 대응되지 않는다)

- 위 개념과 반대되는 `Frozen Enum` 개념 등장
	- 정의 부분에서 `NS_CLOSED_ENUM`를 사용 하여 더 이상 타입이 추가되지 않을 것이라고 정의
	- 따라서 `@unknown default` 선언이 필요없게 된다.

## Checking for integer multiples

```swift
let rowNumber = 4

if rowNumber.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}
```

## count(where:)

```swift
let scores = [100, 80, 85]
let passCount = scores.count { $0 >= 85 }
```

## compactMapValues()

```swift
let finishers1 = times.compactMapValues { Int($0) }
```


## WritableKeyPath를 지원
- Key path가 전체 입력 값을 참조

```swift
class WritableKeyPath<Root, Value> : KeyPath<Root, Value>

let id = \Int.self
var x = 2
print(x[keyPath: id]) // Prints "2"
x[keyPath: id] = 3
print(x[keyPath: id]) // Prints "3"
```

## 가변 인수를 취한 enum 사용 불가

```swift
enum X {
    case foo(bar: [Int]) 
} 

 func baz() -> X {
    return .foo(bar: [0, 1, 2, 3]) 
} 
```

## try?의 표현식을 Optional을 사용하여 중첩 된 옵션을 반한하는 대신 결과로 나오는 optional을 flatten하게 만들어줍니다.

```swift
// Swift 4: 'Int??'
// Swift 5: 'Int?'
let result = try? database?.countOfRows(matching: predicate)


// Swift 4: 'String??'
// Swift 5: 'String?'
let myString = try? String(data: someData, encoding: .utf8)
    
// Swift 4: '[String: Any]??'
// Swift 5: '[String: Any]?'
let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]

// Swift 4: 'String?'
// Swift 5: 'String?'
let fileContents = try? String(contentsOf: someURL)

func doubleOptionalInt() throws -> Int?? {
    return 3
}

// Swift 4: 'Int???'
// Swift 5: 'Int??'
let x = try? doubleOptionalInt()
```


## String interpolation은 성능, 명확성 및 효율성을 향상시켰습니다.

```swift

String(stringInterpolation:
  String(stringLiteral: "hello "),
  String(stringInterpolationSegment: name),
  String(stringLiteral: "!"))

String(stringInterpolation:
  .literal("hello "),
  .interpolation(String.StringInterpolationType(name)),
  .literal("!"))
```


## DictionaryLiteral 타입의 이름이 KeyValuePairs로 변경됩니다.

```swift
extension Sequence {
    func dropTwo() -> DropFirstSequence<Self> { 
        return self.dropFirst(2)
    }
}

extension Collection {
    func dropTwo() -> SubSequence {
        return self.dropFirst(2)
    }
}
```

## 프로토콜은 이제 순응하는 유형을 주어진 클래스의 서브 클래스로 제한합니다

```swift
protocol MyView: UIView { /*...*/ }
protocol MyView where Self: UIView { /*...*/ } 
```

## 자체적으로 didSet 또는 willSet observer 내에서 속성을 설정 할 때 속성이 self 로 설정된 경우 관찰자는 재귀적으로 호출되는 것을 방지합니다.

```swift
class Node {
    var children = [Node]() 
    var depth: Int = 0 {
        didSet { 
            if depth < 0 {
                // Won’t recursively call didSet, because this is setting depth on self. 
                depth = 0
            } 

            // Will call didSet for each of the children,
            // as this isn’t setting the property on self.
            // (Prior to Swift 5, this didn’t trigger property
            // observers to be called again.)
            for child in children { 
                child.depth = depth + 1
            } 
        }
    }
}
```