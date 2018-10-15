#Swift로 자료구조, 알고리즘 공부하기 (1) - Binary Search

##Binary Search란
* 기본적인 탐색방법
* 정렬되어있는 배열에 대해서 탐색을 하는 방법이다

1. 우선 배열의 middle index 값을 계산한다
2. 이후 탐색하려는 값이 배열의 middle index에 존재하는지 확인한다
	1. 존재할 경우, 해당 index를 return한다
	2. 존재하지 않을 경우, middle index의 값이 탐색하려는 값보다 큰지 작은지 확인한다
		1. 작을 경우, middle+1 ~ last 사이의 index를 대상으로 위의 과정을 반복한다
		2. 클 경우, first ~ middle-1 사이의 index를 대상으로 위의 과정을 반복한다
3. 계속 반복하여 탐색하려는 배열의 first값이 last값보다 커지면 탐색이 실패했음을 의미한다


###swift 소스는 다음과 같다 (Playground 에서 작성)

```swift
func BinarySearch(first: Int, last: Int, target: Int, array: [Int]) -> Int {
    
    if first > last {
        return -1
    }
    let middle = (first + last) / 2

    if target == array[middle] {
        return middle
    } else if target < array[middle] {
        return BinarySearch(first, last: middle-1, target: target, array: array)
    } else {
        return BinarySearch(middle+1, last: last, target: target, array: array)
    }

}

func main() {
    
    let array = [1, 4, 8, 9, 11, 23, 45, 80]
    
    let index = BinarySearch(0, last: sizeofValue(array)-1, target: 8, array: array)
    
    if index == -1 {
        print("Search fail")
    } else {
        print("\(index)")
    }
}

main()
```

해당 소스는 [여기에서](https://github.com/kor45cw/DataStructure/tree/master/Swift/BinarySearch.playground) 확인할수 있습니다.