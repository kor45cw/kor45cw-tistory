#Swift로 자료구조, 알고리즘 공부하기 (2) - Hanoi Tower

##Hanoi Tower 정의
* 하노이 탑은 세개의 기둥을 갖는다.
* 위의 원판은 무조건 아래의 원판보다 반지름이 작아야한다. 즉, 크기 순서대로 쌓아야한다.
* 첫번째 기둥에 있는 원판을 모두 두번째 규칙을 지켜가며, 세번째 기둥으로 옮겨야 한다.

##Hanoi Tower 알고리즘
1. A 기둥에서, 2번째부터 n번째까지의 모든 원판을 B 기둥으로 옮긴다.
2. A 기둥의 첫번째 원판을 C기둥으로 옮긴다.
3. B 기둥에서, 2번째부터 n번째까지의 모든 원판을 C 기둥으로 옮긴다.



###swift 소스는 다음과 같다 (Playground 에서 작성)

```swift
func HanoiTower(number: Int, from: String, by: String, to: String) {
    if number == 1 {
        print("towerNumber 1 from "+from+" to "+to);
    } else {
        HanoiTower(number-1, from: from, by: to, to: by);
        print("towerNumber \(number) from "+from+" to "+to)
        HanoiTower(number-1, from: by, by: from, to: to);
    }
}

func main() {
    HanoiTower(3, from: "A", by: "B", to: "C");
}


main()
```

해당 소스는 [여기에서]("https://github.com/kor45cw/DataStructure/tree/master/Swift/HanoiTower.playground") 확인할수 있습니다.
