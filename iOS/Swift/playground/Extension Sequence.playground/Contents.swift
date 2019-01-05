import UIKit

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

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
