#Swift로 자료구조, 알고리즘 공부하기 (3) - Array List

##Array List 정의
기본적으로 리스트 자료구조는 두가지로 구분할 수 있습니다.

> 순차 리스트 : 배열을 기반으로 구현된 리스트
> 
> 연결 리스트 : 메모리의 동적할당을 기반으로 구현된 리스트

그중에서 우리는 순차 리스트, 즉 Array List를 살펴보려고 합니다.

##Array List의 특징
기본적인 리스트 자료구조의 공통적인 특징은 다음과 같습니다.

- 리스트 자료구조는 데이터를 나란히 저장합니다. 그리고 중복된 데이터의 저장을 막지 않습니다.

배열 기반 리스트의 장단점은 다음과 같습니다.

- 배열 기반 리스트의 단점
    - 배열의 길이가 초기에 결정되어야 한다. 변경이 불가능
    - 삭제의 과정에서 데이터의 이동(복사)이 매우 빈번히 일어난다
- 배열 기반 리스트의 장점
    - 데이터의 참조가 쉽다. 인덱스 값을 기준으로 어디든 한번에 참조가 가능하다.

다음은 아래 구현된 소스에 대한 설명입니다.

- listInit : 배열의 길이를 설정하고, currentPosition의 값을 -1로 설정합니다.
- listInsert : ArrayList에 data를 이어 붙여 넣습니다.
- listFirst : ArrayList의 첫번째 인자가 있으면 true를 반환하고, data에 해당 값을 대입합니다.
- listNext : ArrayList에 다음 인자가 있을 경우 true를 반환하고, data에 해당 값을 대입합니다.
- listRemove : currentPosition에 있는 인자를 ArrayList에서 제거합니다.
- listCount : ArrayList에 들어있는 인자의 갯수를 return 합니다.

###swift로 구현된 ArrayList는 다음과 같습니다. (Playground 에서 작성)

```swift
import UIKit

struct arrayList {
    var array: [Int?]
    var numberOfData : Int
    var currentPosition : Int
}

class ArrayList {
    
    let listLength = 100
    
    func listInit(inout list: arrayList) {
        list.array = [Int?](count: listLength, repeatedValue: nil)
        list.numberOfData = 0
        list.currentPosition = -1
    }
    
    func listInsert(inout list: arrayList, data: Int) {
        if list.numberOfData > listLength {
            print("impossible Save")
            return
        }
        
        list.array[list.numberOfData] = data
        list.numberOfData = list.numberOfData + 1
        
    }
    
    func listFirst(inout list: arrayList, inout data: Int) -> Bool {
        if list.numberOfData == 0 {
            return false
        }
        
        list.currentPosition = 0
        data = list.array[0]!
        return true
    }
    
    func listNext(inout list: arrayList, inout data: Int) -> Bool {
        if list.currentPosition >= list.numberOfData - 1 {
            return false
        }
        
        list.currentPosition = list.currentPosition + 1
        data = list.array[list.currentPosition]!
        return true
    }
    
    func listRemove(inout list: arrayList) -> Int? {
        let removePosition = list.currentPosition
        
        let removeData = list.array[removePosition]
        
        for i in 0..<list.array.count-1 {
            list.array[i] = list.array[i+1]
        }
        
        list.numberOfData = list.numberOfData - 1
        list.currentPosition = list.currentPosition - 1
        
        return removeData
    }
    
    func listCount(list: arrayList) -> Int {
        return list.numberOfData
    }
    
}

func main() {
    
    var data : Int = 0
    var list = arrayList.init(array: [Int?](), numberOfData: -1, currentPosition: -1)
    
    ArrayList().listInit(&list)
    
    // Save Data
    ArrayList().listInsert(&list, data: 1);
    ArrayList().listInsert(&list, data: 2);
    ArrayList().listInsert(&list, data: 3);
    ArrayList().listInsert(&list, data: 4);
    
    print("number of current data : \(ArrayList().listCount(list))")
    
    
    if (ArrayList().listFirst(&list, data: &data)) {
        print("\(data) ", terminator:"")
        
        while(ArrayList().listNext(&list, data: &data)) {
            print("\(data) ", terminator:"")
        }
    }
    
    print("")
    
    
    // Delete Data
    if (ArrayList().listFirst(&list, data: &data)) {
        print(data)
        if (data == 1) {
            data = ArrayList().listRemove(&list)!;
        }
        
        while(ArrayList().listNext(&list, data: &data)) {
            if (data == 1) {
                data = ArrayList().listRemove(&list)!;
            }
        }
    }
    
    print("number of current data : \(ArrayList().listCount(list))")

    if (ArrayList().listFirst(&list, data: &data)) {
        print("\(data) ", terminator:"")
        
        while(ArrayList().listNext(&list, data: &data)) {
            print("\(data) ", terminator:"")
        }
    }
}

main()
```

해당 소스는 [여기에서]("https://github.com/kor45cw/DataStructure/tree/master/Swift/ArrayList.playground") 확인할수 있습니다.
