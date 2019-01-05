import UIKit
import XCTest

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


extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return self.map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

extension Dictionary {
    mutating func merge<S: Sequence>(_ other: S) where S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(sequence)
    }
    
    func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>( self.map { key, value in
            return (key, transform(value))
        })
    }
}


func testUniqueFunc() {
    XCTAssertEqual([1, 1, 2, 3, 1, 2, 3].unique(), [1, 2, 3])
    XCTAssertEqual(["A", "A", "C", "F", "C", "B"].unique(), ["A", "C", "F", "B"])
}

func testAccumulateFunc() {
    XCTAssertEqual([1, 2, 3, 4, 5].accumulate(0, +), [1, 3, 6, 10, 15])
}

func testMergeFunc() {
    var dict = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5]
    dict.merge(["A": 11, "B": 12, "C": 13])
    XCTAssertEqual(dict, ["A": 11, "B": 12, "C": 13, "D": 4, "E": 5])
}

func testDictInit() {
    let array = (1...5).map { (key: $0, value: "true") }
    let newDict = Dictionary(array)
    XCTAssertEqual(newDict, [1: "true", 2: "true", 3: "true", 4: "true", 5: "true"])
}

func testMapValueFunc() {
    let dict = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5]
    let newDict = dict.mapValue { $0 * 2 }
    XCTAssertEqual(newDict, ["A": 2, "B": 4, "C": 6, "D": 8, "E": 10])
}

