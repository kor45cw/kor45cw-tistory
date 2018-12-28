# 삽입정렬 (The insertion Sort)
- 평균적으로: O(n^2)
- 정렬된 데이터거나 데이터의 크기가 작을 경우: O(nlogn)

## 알고리즘
- comparable 프로토콜을 따르는 타입에 대해서 in-place 정렬을 수행
- N-1번 수행하여 정렬된다.


```swift
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
```

## 작동방법
- 왼쪽에서부터 정렬하기 시작하여 순서대로 비교해 나간다.
- 이후 해당 원소보다 i 번째 원소가 더 클 경우 그 자리에 해당 원소를 넣고 나머지 원소들을 하나씩 뒤로 민다.

## 사용처
- 대부분 정렬되어 있고 가끔씩 조금만 변화가 필요한 요소가 있을 때 사용 가능

## 최적화
- 더 큰 데이터에 대해서 최적화 하는 것은 큰 의미가 없음