# 퀵소트 (Quick Sort)
- 분할/정복 알고리즘
- 널리 사용되는 고속 정렬 알고리즘
- 초기 배열을 선택한 pivot에 따라, 한쪽을 상위로 다른 한쪽을 하위로 나눈다.
- 평균: O(nlogn), 최악: O(n^2)


## Algorithm - Lomuto's implementation
```swift
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    if lo < hi {
        let pivot = partition(&list, lo: lo, hi: hi)
        
        quickSort(&list, lo: lo, hi: pivot - 1)
        quickSort(&list, lo: pivot+1, hi: hi)
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
    let pivot = list[hi]
    var i = lo
    
    for j in lo..<hi {
        if list[j] <= pivot {
            list.swapAt(i, j)
            i = i + 1
        }
    }
    list.swapAt(i, hi)
    return i
}
```

## Algorithm - Hoare's Implementation
- Lomuto 구현법 보다 평균적으로 3배 적은 swap을 수행


```swift
func quickSort<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) {
    if lo < hi {
        let pivot = partition(&list, lo: lo, hi: hi)
        
        quickSort(&list, lo: lo, hi: pivot)
        quickSort(&list, lo: pivot+1, hi: hi)
    }
}

func partition<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> Int {
    let pivot = list[lo]
    var i = lo - 1
    var j = hi + 1
    
    while true {
        i = i + 1
        while list[i] < pivot { i = i + 1 }
        j = j - 1
        while list[j] > pivot { j = j - 1 }
        if i >= j {
            return j
        }
        list.swapAt(i, j)
    }
}
```

## pivot의 선택
- 잘못된 방법 : 첫번째와 마지막 요소
	- Lomuto 분할 방식에서, 일반적인 방법은 첫번째 또는 마지막 요소를 선택하여 brute force 적인 접근 방법을 취하는 것이다.
	- 최악의 복잡성을 초래하기 때문에 O(n^2)로 매우 느릴것이다.

- 잘못된 방법 : 랜덤 요소 선택
	- 대부분의 경우, 데이터가 거의 정렬되어 있다고 하더라도 잘 수행된다.

- 맞는 방법
	- 3가지 전략의 median 을 사용하는 것이다.

## 개선된 피봇 선택 Algorithm
```swift
private func getMedianOfThree<T: Comparable>(_ list: inout [T], lo: Int, hi: Int) -> T {
    let center = lo + (hi + lo) / 2
    if list[lo] > list[center] {
        list.swapAt(lo, center)
    }
    
    if list[lo] > list[hi] {
        list.swapAt(lo, hi)
    }
    
    if list[center] > list[hi] {
        list.swapAt(center, hi)
    }
    
    list.swapAt(center, hi)
    
    return list[hi]
}
```

## 최적화
- 배열이 매우 작은 경우: 삽입정렬을 수행
- Dijkstra에 의해 제안된 네덜란드 국기 문제 와 같은 선형 시간 분할 방식을 사용하여 반복된 요소를 처리한다.
- tail call 을 사용하여 더 큰 부분의 분할을 복구함으로써 O(log n) 이하의 공간을 사용하도록 한다.


