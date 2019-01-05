# Extension Sequence


- **unique 함수** 
	- 요소들에서 중복 값을 제외한 Sequence를 리턴함
	- Sequence에서 중복을 제외하는 작업은 종종 많이 쓰이는데요, Set 자료구조를 이용하여 중복 여부를 판단하는 로직을 넣어 성능을 최적화 시킬 수 있습니다. 하지만 주의할 점은 Set의 요소들은 Hashable 프로토콜을 conform 해야 함으로 Extension에 조건이 붙습니다.

```swift
extension Sequence where Iterator.Element: Hashable {
       func unique() -> [Iterator.Element] {
           var seen: Set<Iterator.Element> = []
           return self.filter {
               if seen.contains($0) {
                   return false
               } else {
                   seen.insert($0)
                   return true
               }
           }
    }
}
// Test
func testUniqueFunc() {
       XCTAssertEqual([1, 1, 2, 3, 1, 2, 3].unique(), [1, 2, 3])
       XCTAssertEqual(["A", "A", "C", "F", "C", "B"].unique(), ["A", "C", "F", "B"])
}
```

## Extension Array 

- **accumulate 함수** 
	- 요소들의 조합을 리턴 (reduce 함수와 비슷하지만 임시 조합의 배열로 반환)
	- reduce함수와 모양새가 비슷하지만, 내부적으로 map 함수를 사용하여 요소들의 배열을 반환하는데 차이가 있습니다.

```swift
extension Array {
       func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
           var running = initialResult
           return self.map { next in
               running = nextPartialResult(running, next)
               return running
           }
       }
}
// Test
func testAccumulateFunc() {
       XCTAssertEqual([1, 2, 3, 4, 5].accumulate(0, +), [1, 3, 6, 10, 15])
}
```

##Extension Dictionary #

- **merge 함수** 
	- 딕셔너리에 다른 딕셔너리를 병합
	- 주의할 점은 merge함수로 새로운 Dictionary를 만드는 것이 아니라, 원본의 딕셔너리의 값이 바뀌기 때문에 함수에 mutating 키워드를 적어서 구현해야 합니다. 
	- 참고로 딕셔너리의 Iterator.Element의 타입은 (key: Key, value: Value)와 같습니다.

```swift
extension Dictionary {
       mutating func merge<S: Sequence>(_ other: S) where S.Iterator.Element == (key: Key, value: Value) {
            for (k, v) in other {
                self[k] = v
            }
       }
}   
// Test
func testMergeFunc() {
       var dict = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5]
       dict.merge(["A": 11, "B": 12, "C": 13])
       XCTAssertEqual(dict, ["A": 11, "B": 12, "C": 13, "D": 4, "E": 5])
}
```

- **init 함수** : 
	- 딕셔너리 또는 튜플 Array를 인자로 받아 딕셔너리 만들기

```swift
extension Dictionary {
       init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
           self = [:]
           self.merge(sequence)
       }
}
// Test
func testDictInit() {
        let array = (1...5).map { (key: $0, value: "true") }
        let newDict = Dictionary(array)
        XCTAssertEqual(newDict, [1: "true", 2: "true", 3: "true", 4: "true", 5: "true"])
}
```

- **mapValue** 
	- 딕셔너리의 Value들만 map함수 적용시키는 함수

```swift
extension Dictionary {
       func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> [Key: NewValue] {
           return Dictionary<Key, NewValue>( self.map { key, value in
               return (key, transform(value))
           })
       }
}
// Test
func testMapValueFunc() {
        let dict = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5]
        let newDict = dict.mapValue { $0 * 2 }
        XCTAssertEqual(newDict, ["A": 2, "B": 4, "C": 6, "D": 8, "E": 10])
}
```