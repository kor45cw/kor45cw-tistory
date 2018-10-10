# iOS interview ch01


## @IBOutlet weak 선언
- nib 파일에서 최상위 view(보통 self.view)가 IBOutlet으로 정의한 view를 소유하고 있으므로 weak 지시어로 생성하여도 무방하다.
	- 이유는 뷰가 객체들을 잡고 있기 때문에 뷰가 dealloc되지 않는 한 안의 객체들이 dealloc되지 않기 때문이다.
- iOS 디바이스가 low-memory warning을 받으면 view가 unload되는데 이때 weak으로 처리해야 IBOutlet에 연결된 view도 자동으로 해제된다.

## Context
- 맥락. 어떤 위치에 어떤 값이 존재할 수 있는 맥락.
- 옵셔널은 맥락은 존재하지만 값이 필연적으로 존재하지는 않을 수도 있는 부분에 들어감.
- 값과 컨텍스트는 다르다. 그래서 옵셔널은 값을 대신할 수 없다!

## Functor
- 맵을 적용할 수 있는 컨테이너 타입 
- 값이 있거나 또는 없음을 표현하는 Optional Type도 해당
- 컨테이너를 해제하지 않은 채로 값을 연산한 후 되돌려준다.

## Monad
- Monad는 Fuctor의 한 유형
- 값이 있을지 없을지 모르는 컨텍스트를 가지는 함수객체
- 여기에 대응하는 것이 flatMap! 값이 있을지 미지수인 컬렉션을 쉽게 조작할 수 있도록 해줍니다.

## GCD (Grand Central Dispatcher)
- Dispatch Queue는 Task를 적재하는 데이터 구조입니다.
- 데이터 구조의 Queue이므로 작동 방식이 Serial(순차적)이든 Concurrent(동시)이든, 언제나 FIFO(First In First Out)방식으로 동작합니다.

- Serial Dispatch Queue
    - Queue에 Push된 순서대로 1개의 Task씩 실행하며, 해당 Task가 끝나기를 기다립니다. Queue를 여러 개 만들 수도 있으며, 각 Queue들은 Concurrency하게 돌아갑니다.
- Concurrent Dispatch Queue
    - Global Dispatch Queue라고도 불리며, 여러 개의 task를 Concurrent하게 실행합니다. 실행순서는 Push한 순서대로 실행되며, 동시에 실행되는 Task는 시스템의 환경에 따라 달라집니다.
- Main Dispatch Queue
    - Application의 Main Thread에서 Serial하게 실행되는 Task들을 관리하는 Queue입니다. 해당 Queue는 Application의 Run loop에서 작동하게 됩니다.