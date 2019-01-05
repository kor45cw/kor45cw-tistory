## Extension

- **unique 함수** 
	- 요소들에서 중복 값을 제외한 Sequence를 리턴함

```swift
extension Sequence where Iterator.Element: Hashable {
       func unique() -> [Iterator.Element] {
           var seen: [Iterator.Element: Bool] = [:]
           return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
```

- **scan 함수** 

```swift
extension Array where Element == Int {
    func scan() -> [Int] {
        return self.reduce(into: [Int]()) { (sums, element) in
            if let sum = sums.last {
                sums.append(sum + element)
            } else {
                sums.reserveCapacity(self.count)
                sums.append(element)
            }
        }
    }
}
```