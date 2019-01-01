# Bad Case in Swift

> [출처](https://www.avanderlee.com/swift/performance-collections/)

## contains > first(where:) != nil

- Best

```swift
let numbers = [0, 1, 2, 3]
numbers.contains(1)
```

- Bad

```swift
let numbers = [0, 1, 2, 3]
numbers.filter { number in number == 1 }.isEmpty == false
numbers.first(where: { number in number == 1 }) != nil
```


## checking isEmpty > comparing count to zero.

- Best

```swift
let numbers = []
numbers.isEmpty
```

- Bad

```swift
let numbers = []
numbers.count == 0
```

## 첫번째 요소를 가져오는 것은 where 조건으로 조절

- Best

```swift
let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
let firstNegative = numbers.first(where: { $0 < 0 })
```

- Bad

```swift
let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
let firstNegative = numbers.filter { $0 < 0 }.first
```

## min, max는 소팅해서 가져오는게 아니다.

- Best

```swift
let numbers = [0, 4, 2, 8]
let minNumber = numbers.min()
let maxNumber = numbers.max()
```

- Bad

```swift
let numbers = [0, 4, 2, 8]
let minNumber = numbers.sorted().first
let maxNumber = numbers.sorted().last
```

## 조건을 다 만족하는 지 확인할 수 있는 allSatisfy를 쓰자

- Best

```swift
let numbers = [0, 2, 4, 6]
let allEven = numbers.allSatisfy { $0 % 2 == 0 }
```

- Bad

```swift
let numbers = [0, 2, 4, 6]
let allEven = numbers.filter { $0 % 2 != 0 }.isEmpty
```
