# iOS interview ch06

##What is JSON/PLIST limits?
- 개체를 생성한 후 디스크에 직렬화했습니다.
- 매우 한정적인 사용 경우가 존재합니다.
- 복잡한 쿼리나 필터를 사용할 수 없습니다.
- 매우 느립니다.
- 매번 필요할 경우 직렬화를 하거나 직렬화를 해제하여야합니다.
- not thread-safe.

##What is Realm benefits?
- An open-source database framework.
- Implemented from scratch.
- Zero copy object store.
- Fast.


##How many are there APIs for battery-efficient location tracking?
- 3가지 API 존재.
- 중대한 위치 변경: 약 500m 이동 시 마다 알려줍니다. (평균적으로 1km)
- 지역 모니터링: 특정 원형 공간을 들어가고 나오는 것을 트래킹 합니다 (100m)
	- GPS 다음으로 정확한 API
- 방문 이벤트: 특정 장소를 들어왔는지 아닌지 체크하는 API

##What is the Swift main advantage? 
- Optional Types: 앱의 크래시 방지
- Built-in error handling
- Closures
- Much faster compared to other languages
- Type-safe language
- Supports pattern matching

##Explain generics in Swift? 
- 기본 데이터 유형에 대해 specific하지 않은 코드를 생성합니다.

##Explain lazy in Swift? 
- 초기 값은 속성을 처음으로 호출할 때만 계산됩니다. 

##Explain what is defer?
- 실행 중 현재 scope를 벗어나는 경우 실행할 코드 블록을 제공하는 키워드.

##How to pass a variable as a reference?
- value type을 전달할 경우, 해당 변수는 데이터의 복사값을 생성합니다.
- reference type을 전달할 경우, 해당 변수는 메모리에 있는 원래의 데이터를 가리킵니다.

##Why it is better to use higher order functions?
- function을 매개변수로 사용하거나 그 결과로 function을 반환하는 function을 고차함수라고 합니다.
- Swift는 이러한 기능을 CollectionType으로 정의합니다.

##What is Concurrency?
- 프로그램 실행 경로를 분할하여 동시에 실행될 수 있도록 합니다.
	- 프로세스, 스레드, 멀티스레딩 등등
- Process, An instance of an executing app
- Thread, Path of execution for code
- Multithreading, Multiple threads or multiple paths of execution running at the same time.
- Concurrency, Execute multiple tasks at the same time in a scalable manner.
- Queues, Queues are lightweight data structures that manage objects in the order of First-in, First-out (FIFO).
