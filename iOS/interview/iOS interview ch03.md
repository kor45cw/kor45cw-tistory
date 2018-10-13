# iOS interview ch03


## Pod install, Pod update 차이
- 이미 사용하고 있더라도 새로 추가/제거 하는 경우에는 무조건 install을 사용하세요
- Pod 을 최신으로 업데이트 할 경우에만 update를 사용하세요

### Install
- `Podfile.lock` 리스트에 없는 것들은 추가하여 새로 설치한다. 
	- 있는 것들은 새버전을 체크하지 않고 설치한다.
	- 없는 것들은 작성한 버전과 매칭되는 것을 찾아 설치한다.


### Update
- `Podfile.lock`에 있는 버전을 고려하지않고 업데이트된 버전을 찾으려 시도 (버전 제한은 유지)

## RxSwift : Driver?
- Driver는 UI layer에서 좀 더 직관적으로 사용하도록 제공하는 unit입니다. 
- Driver는 MainScheduler에서 사용합니다.
- UI 관련된 것에는 Driver를 쓰는 것이 좋습니다.


## MVVM, MVC, MVP 
- 화면에 보여주는 로직과 실제 데이터가 처리 되는 로직을 분리

### MVC (Model + View + Controller)
1. Controller로 사용자의 입력이 들어옵니다.
2. Controller는 Model을 데이터 업데이트 및 불러오고
3. Model은 해당 데이터를 보여줄 View를 선택해서 화면에 보여주게 됩니다.

- MVC는 단점이 있습니다. View와 Model이 서로 의존적이라는 점입니다.

### MVP (Model + View + Presenter)
1. View로 사용자의 입력이 들어옵니다.
2. View는 Presenter에 작업 요청을 합니다.
3. Presenter에서 필요한 데이터를 Model에 요청 합니다.
4. Model은 Presenter에 필요한 데이터를 응답 합니다.
5. Presenter는 View에 데이터를 응답 합니다.
6. View는 Presenter로부터 받은 데이터로 화면에 보여주게 됩니다.

- 이런 MVP도 단점이 있습니다. View와 Model은 의존성이 없는 대신 View와 Presenter가 1:1로 강한 의존성을 가지게 됩니다.

### MVVM (Model + View + ViewModel)
1. View에 입력이 들어오면 Command 패턴으로 ViewModel에 명령을 합니다.
2. ViewModel은 필요한 데이터를 Model에 요청 합니다.
3. Model은 ViewModel에 필요한 데이터를 응답 합니다.
4. ViewModel은 응답 받은 데이터를 가공해서 저장 합니다.
5. View는 ViewModel과의 Data Binding으로 인해 자동으로 갱신 됩니다.


## 앱의 생명주기

1. 아이폰에서 사용자가 어플리케이션을 Tap 해서 실행
2. 해당 어플리케이션의 main 실행
3. main 에서 UIApplicationMain() 실행  (@UIApplicationMain 어노테이션이 있는 클래스를 찾아 AppDelegate 객체를 생성)
4. AppDelegate 의 applicationDidFinishLaunching: 을 호출
5. applicationDidFinishLaunching이 완료되면  EventLoop로 들어감 (Main Event Loop를 실행)
6. 이제부터는 개발자가 코드로 구현한 작업들 수행
7. 어플리케이션 종료시도
8. AppDelegate의 applicationWillTerminate: 호출
9. 어플리케이션 종료

- Not Running: 앱이 실행되지 않은 상태
- Inactive: 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태
- Active: 앱이 실행중이며 이벤트가 발생한 상태
- Background: 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태
- Suspened: 앱이 백그라운드에 있고 실행되는 코드가 없는 상태
(Inactive와 Active 상태를 합쳐서 Foreground 라고 함)

- application(_:didFinishLaunching:) - 앱이 처음 시작될 때 실행
- applicationWillResignActive: - 앱이 active 에서 inactive로 이동될 때 실행 
- applicationDidEnterBackground: - 앱이 background 상태일 때 실행 
- applicationWillEnterForeground: - 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)
- applicationDidBecomeActive: - 앱이 active상태가 되어 실행 중일 때
- applicationWillTerminate: - 앱이 종료될 때 실행


## 뷰 컨트롤러의 생명주기 : 구체적으로
- ViewDidLoad
	- 해당 뷰컨트롤러 클래스가 생성될 때(ViewWillAppear전에 실행) 실행됩니다. Low memory와같은 특별한 경우가 아니라면 딱 한번만 실행되기 때문에 초기화 할 때 사용 할 수 있습니다.
- ViewWillAppear
	- 뷰 컨트롤러가 화면에 나타나기 직전에 실행됩니다. 뷰 컨트롤러가 나타나기 직전에 항상 실행되기 때문에 해당 뷰 컨트롤러가 나타나기 직전마다 일어나는 작업들을 여기에 배치 시킬 수 있습니다.
- ViewDidAppear
	- 뷰 컨트롤러가 화면에 나타난 직후에 실행됩니다. 화면에 적용될 애니메이션을 그리거나 API로 부터 정보를 받아와 화면을 업데이트 할 때 이곳에 로직을 위치시키면 좋습니다. 왜냐하면 지나치게 빨리 애니메이션을 그리거나 API에서 정보를 받아와 뷰 컨트롤러를 업데이트 할 경우 화면에 반영되지 않습니다.
- ViewWill/DidDisappear
	- 뷰 컨트롤러가 화면에 나타난 직전/직후에 실행됩니다.