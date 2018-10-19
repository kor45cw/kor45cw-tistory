# iOS interview ch07

##Grand Central Dispatch (GCD)
- GCD는 뒷단에서 스레드를 관리하면서 작업을 동시에 실행 할 수 있는 low-level의 객체기반 API를 제공하는 라이브러리입니다.
- Dispatch Queue: FIFO 순서로 작업을 실행합니다.
- Serial Dispatch Queue: 한번에 하나씩 작업을 실행합니다.
- Concurrent Dispatch Queue: 작업이 완료될때까지 기다리지않고, 가능한 많은 작업을 실행합니다.
- Main Dispatch Queue: 메인 스레드에서 작업을 실행하는 전역적으로 사용가능한 Serial Queue입니다.

##Readers-Writers
- 여러개의 스레드를 동시에 읽을 수 있는 반면, 쓰기는 오직 단 하나의 스레드에서만 진행해야 합니다. 이 문제의 해결 방법은 동시 읽기 전용 엑세스와 독점 쓰기 엑세스를 허용하는 reader-writer lock을 하는 것입니다.
- race contidion: 둘 이상의 스레드가 공유데이터에 엑세스 할 수 있고, 동시에 데이터 변경시도를 하면 발생
- Deadlock: 두개 이상의 작업이 다른 작업이 완료될 떄까지 기다릴 때 교착상태가 발생
- Readers-Writers problem: 여러개의 스레드를 동시에 읽을 수 있는 반면, 쓰기는 오직 단 하나의 스레드에서만 진행해야 합니다.
- Readers-writer lock: 공유 리소스에 대한 읽기 전용 동시 엑세스를 허용하고 쓰기작업에 대해서는 독점 엑세스를 허용해야합니다.
- Dispatch Barrier Block: concurrent queue를 사용할 때 직렬 방식의 병목 현상을 만듭니다.

## KVC — KVO
- KVC는 Key-Value Coding의 약자입니다. 개발 시 속성 이름을 정적으로 알 필요 없이 런타임에 문자열을 사용하여 개체의 속성에 액세스할 수 있는 메커니즘입니다.
- KVO는 Key-Value Observing의 약자입니다. 컨트롤러 또는 클래스가 속성 값의 변경을 관찰할 수 있습니다. KVO에서 개체는 특정 속성의 변경 사항을 통지하도록 요청할 수 있습니다. 해당 속성이 값이 변경될 때마다 관찰자에게 자동으로 통지됩니다.


## Please explain Swift’s pattern matching techniques
- Tuple patterns are used to match values of corresponding tuple types.
- Type-casting patterns: allow you to cast or match types.
- Wildcard patterns: match and ignore any kind and type of value.
- Optional patterns: optional 값을 일치시키는 데 사용됩니다.
- Enumeration case patterns: 기존 열거 유형의 case와 일치합니다. 
- Expression patterns: 주어진 값과 지정된 식을 비교할 수 있습니다.

##What are benefits of Guard?
- avoiding the pyramid of doom
- 브레이크 또는 리턴을 사용하여 function을 조기에 종료하는 것

##explain Method Swizzling in Swift
- Objectvie-C와 다른 언어에서 dynamic method dispatching을 지원하는 기능으로 알려져 있다.
- swizzling을 통해서 런타임에 함수간의 매핑을 변경하여 method의 구현을 다른 것으로 대체할 수 있다. 
- Swift 클래스가 스위즐링을 하려면 다음 요소를 준수해야한다
	- NSOjbect를 상속해야한다.
	- swizzling할 메소드에 dynamic attribute를 갖고 있어야한다.

##What is the difference Non-Escaping and Escaping Closures?
- non-escaping closure의 생명주기
	- Pass a closure into a function
	- The function runs the closure (or not)
	- The function returns

- escaping closuer는 함수내에서 클로져를 실행 할 수 있는 것을 의미.
- 클로져의 extra bit는 함수보다 오래 지속되는 위치에 저장됩니다.
- 클로져가 함수를 벗어날 수 있는 몇가지 방법
	- Asynchronous execution: 비동기식으로 클로져를 실행하면 queue가 클로져를 갖고 있습니다. 클로져가 언제 실행 될지는 function이 반환되기전에는 완료될 것이라는 보장이 없습니다.
	- Storage: 클로져를 글로벌 변수, 속성 등으로 저장을 하면 클로져를 탈출할 수 있습니다.

##Explain #keyPath() ?
- `#keyPath()`를 사용하면 정적 문자열 또는 StringLiteralConvertible로 사용되는 키-경로 문자 문자열로 인해 정적 유형 검사가 수행됩니다.
- 그 시점에 아래 것들을 보장하는지 체크됩니다.
	- 그것이 실제로 존재하는지
	- Objective-C에 적절히 노출되는지