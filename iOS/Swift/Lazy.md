# Lazy

## Lazy Variable

- 어느 시점에 사용을 하는 경우 변수를 미리 초기화 시켜놓거나 불리는 시점에 맞춰 초기화를 해야한다. 
	- lazy를 사용하게 되면 그런 걱정이 필요없어지게 된다.

```swift
class Lazy {
    lazy var label: UILabel = UILabel()
    
    func add(text: String?) {
        label.text = text
    }
}

let object = Lazy()
object.add(text: "text")
```

- 초기 init 시에 UILabel이 초기화 되는것이 아니라, add함수가 불릴 경우 UILabel 객체가 생성이 되고 label에 text를 넣을 수 있게 됩니다. 이후 같은 변수 사용할 경우 다시 초기화가 진행되지 않고 이전에 생성된 변수를 그대로 사용하게 됩니다.

##Lazy Sequence
- SequenceType, CollectionType protocol 에는 lazy라는 computed property가 존재.
	- 해당 프로퍼티는 LazySequence, LazyCollection를 반환
	- lazy한 방식으로 동작하게 도와준다.

- lazy를 사용할 경우 접근한 요소에 대한 연산만 수행
	- 연산비용이 많이들어가는 클로져를 사용하여 배열의 요소를 다뤄야할 경우 훨씬 효과적이게 된다.



```swift
(1...200).lazy
    .map { $0 * 2 }
    .prefix(2)

// 연산을 3번만 진행하게 됩니다. (prefix 2를 찾을 때 까지)

//lazy키워드를 처음 사용했을 경우 뒤에 연차적으로 고차함수를 쓸 경우 똑같이 적용이 됩니다.
array.lazy.filter{}.map{}
```

