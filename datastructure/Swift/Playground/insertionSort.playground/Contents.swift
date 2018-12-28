public func insertionSort<T: Comparable>(_ input: [T]) -> [T] {
    guard input.count > 1 else { return input }
    var list = input
    for i in 1..<list.count {
        let x = list[i]
        var j = i
        while j > 0 && list[j-1] > x {
            list[j] = list[j-1]
            j -= 1
        }
        list[j] = x
    }
    return list
}

let input = [4, 6, 5, 2]
print(insertionSort(input))
