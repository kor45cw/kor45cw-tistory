
# 스위프트 메모리 구조 (Swift Memory Layout)
- [출처](https://medium.com/@JimmyMAndersson/introduction-to-swift-memory-layout-114141149ad2)

## 참조 타입 객체
- 간단한 클래스는 참조 타입이다.
	- 즉, 단일 클래스 객체는 여러 변수에 의해 참조되고 조작될 수 있다.

```swift
class MyClass {
  var a: Int
  init(a: Int) {
    self.a = a
  }
}
var A = MyClass(a: 1)
```

- 위의 예는 간단한 클래스의 예시이다. 이를 통해 어떤일이 일어나는지 파악해 보려한다.
- 우리가 MyClass의 init을 호출할 때, 메모리에 우리의 객체를 저장하기 위한 충분한 메모리를 할당하게 된다. 그리고 여기서 우리는 `heap`을 살펴볼 필요가 있다.

- 힙은 동적할당에 사용되는 기억의 한 부분이다.
	- 앱을 실행할 때 즉시 새로운 참조 타입 객체를 만들어야 하는 경우 힙에 공간을 요청해야 한다는 것이다.
	- 이 부분은 데이터를 손상시키지 않고 동시에 여러 개의 스레드를 처리할 수 있어야 하므로 동일한 메모리 블록을 두 번 할당하는 것을 방지하고, 병렬 할당 호출을 처리하는 메커니즘이 필요하다. (이것은 상당한 시간이 걸리는 일이라는 것을 가정하고 진행하도록 한다)

- 클래스의 실제 값을 초기화하는 것 이외에도 일부 메타데이터 값이 초기화되고 있다. (type data and 참조 카운터 포함)

- ARC (Automatic Reference Counting)
	- 객체가 사용되고 있는지를 추적하기 위한 장치
	- 어떤 변수에서도 참조하지 않는 객체는 안전하게 제거 될수 있고, 그 메모리는 반환될 수 있다.
	- 훌륭하고 편한 기능이지만, 객체 생성 혹은 공유 시 마다 카운터를 업데이트 해야하는 부하를 수반한다.


## 값 타입 객체 (Value Type Objects)
- enum, struct는 값 타입이다.
- 여기서는 `stack`을 살펴볼 필요가 있다.
	- 데이터가 쌓이고 새로운 데이터를 추가하면 데이터가 맨 위에 추가된다는 것이다.
	- 데이터의 제가는 또한 메모리 공간의 맨위 끝으로 제한되기 때문에 우리는 현재 맨 위에 있는 데이터만 제거 가능하다.
	- 장점: 메모리 할당 및 할당 해제는 단순한 증가 또는 감소 작업에 의해 이루어지며, 따라서 매우 빠르다.
	- 단점: 이 구조가 힙이 제공할 수 있는 동적 할당과 양립할 수 없다.

```swift
struct Point {
  var x: Double
  var y: Double
}
var P = Point(x: 1, y: 2)
```

- 위의 구조가 2D 좌표계에서 점을 나타낸다고 가정해 봅시다.
	- 이 구조는 스택에 배치 될 것이며, 이는 스택포인터의 두 단계를 줄이고 x와 y 값을 거기에 넣는 방식으로 할당된다는 것을 의미합니다.
	- 관례상 스택이 "아래로" 자라기 때문에 포인터는 감소하게 됩니다.

- Array의 경우는?
	- 어레이는 동적 타입이며, 런타임에 크기를 늘리거나 축소할 수 있다.
	- 따라서 배열은 이런 측면 때문에 참조 유형처럼 취급된다. -> (Heap에 할당)
	- 어레이 할당에 드는 비용은 나중에 어레이 크기를 조정하기가 훨씬 쉽다는 사실로 보충된다.
	- 어레이가 얼마나 많은 값을 보유하는지 정확히 알고 있다면, reserveCapacity(_:)를 사용해서 할당 비용을 더욱 줄일 수 있다.
		- 처음부터 정확한 메모리 크기를 할당할 것이고, 더 이상 할당 비용을 부담하지 않을 것이다.

##How To Choose?

- 참조 타입을 사용하는 경우
	- 일반적으로 여러 부분에서 변형 상태를 공유할 수 있어야한다
	- 새로운 메모리의 할당을 피해야 하는 상황
	- 외부 프레임워크의 일부를 subclass 해야하는 상황

- 값 타입을 사용하는 경우
	- 위에서 말한 경우를 제외한 대부분의 경우
	- 버그의 추적을 더 쉽게 만들고
	- 할당 및 관리 방식덕분에 성능을 향상 시킨다.