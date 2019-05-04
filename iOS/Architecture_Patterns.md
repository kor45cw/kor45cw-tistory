# Architecture Patterns

## 왜 아키텍처를 고르는데 신중해야하는가?

- 그 클래스가 UIViewController의 자식클래스이다.
- 당신의 데이터들이 UIViewController에서 바로 저장된다.
- UIView들이 거의 아무 일도 하지않는다.
- Model이 빈 데이터 구조이다.
- 유닛 테스트로 아무것도 하지 않는다.


- 좋은 아키텍처의 특징을 정의해보자:
	- 엄격한 룰에 따라 개체들간의 책임 분리(Distribution)를 균형있게 해야한다.
	- 첫번째 말한 특징으로부터 나올 수 있는 테스트들이 가능(Testability)해야한다.
	- 사용하기 편해야(Ease of use)하고 유지보수하기 쉬워야한다.


### 왜 분리해야하나?
- 이게 어떻게 동작하는지 알아낼려고 노력하는 동안 우리의 뇌에서 균등하게 생각하도록 해준다. 
- 가장 빨리 복잡한 것을 극복하는 방법은 하나의 책임 단위로 수많은 개체들의 책임을 쪼개는 것이다.


## MVC, MVP, MVVM
- Models
	- 데이터나 데이터 접근 레이어 소유를 책임지는 부분
- Views 
	- 레이어에 표현되있는 것을 책임지는 부분(GUI)
	- iOS 환경에서는 'UI'가 접두로 붙는다.
- Controller/Presenter/ViewModel
	- Model과 View를 붙여준다. 
	- 보통 유저가 View에서 어떤 액션을 취할때 Model을 변경하거나 Model이 변경되었을 때, View를 갱신하는 책임을 가지는 부분


###개체들을 나눌때 이점:
- 이전보다 더 잘 이해할 수 있다(이미 알고 있다 하더라도).
- 재사용 가능하다(대부분 View와 Model에 적용 가능하다).
- 독립적으로 테스트 가능하다.


## Apple MVC
- Distribution
	- 사실 뷰와 모델은 분리되 있지만, View와 Controller는 딱 붙어있다.
- Testability
	- 거지같은 분리 때문에 Model만 테스트 가능할 것이다.
- Ease of use
	- 다른 패턴에 비해 코드가 적게 든다. 
	- 추가로 많은 사람들이 친숙하게 사용하기도하며 경험해보지 못했던 개발자도 쉽게 접근할 수 있다.

- Cocoa MVC는 개발 속도면에서는 최고의 아키텍처 패턴이다.

## MVP
- MVC에서는 View가 Controller와 서로 딱 붙어있지만 MVP에서 중간다리 역할을 하는 Presenter.
	- View Controller의 라이프 사이클에 아무런 영향을 끼치지도 않으며, 
	- View가 쉽게 테스트가능한 복사본(moked)을 만들 수 있다.
	- Presenter에는 레이아웃 관련 코드가 없고 오직 View의 데이터와 상태를 갱신하는 역할만 가진다.

- UIViewController의 자식클래스에 Presenter가 아닌 View들이 있다. 
	- 이러한 구분은 좋은 테스트 용이함을 제공하지만, 
	- 수작업의 데이터나 이벤트 바인딩을 따로 만들어야하기때문에 개발 속도에대한 비용도 따라 온다.

- 뷰가 Model에대해 알기를 원치 않기 때문에, 
- 현재 View Controller(View일 것이다)를 모아서 동작시키는건 옳지 않으므로 다른곳에서 동작시켜야한다. 
- 예를들어, 우리는 앱에서 범용적인 모아서 수행하거나 View-to-View를 보여주기위한 Router를 돌릴 수 있다. 

```swift
import UIKit

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingView: class {
    func setGreeting(greeting: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter {
    unowned let view: GreetingView
    let person: Person
    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    func showGreeting() {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.view.setGreeting(greeting)
    }
}

class GreetingViewController : UIViewController, GreetingView {
    var presenter: GreetingViewPresenter!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        self.presenter.showGreeting()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    
    // layout code goes here
}
// Assembling of MVP
let model = Person(firstName: "David", lastName: "Blaine")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
view.presenter = presenter
```

- Distribution 
	- Presenter와 Model의 책임을 거의 분리했고 View는 좀 빈껍데기가 된 셈이다(위 예제에서는 Model도 빈껍데기 같았지만..)
- Testability
	- 최고로 좋다. View의 재사용가능 덕분에 대부분의 비지니스 로직을 테스트 할 수 있다.
- Easy of use
	- 위에서 본 비현실적인 예제에서는 MVC에비해 코드의 양이 2배정도 더 많이 들지만 MVP의 아이디어는 굉장히 명료하다.

- iOS에서 MVP는 테스트하기엔 좋지만 코드가 길어진다.


## MVVM
- MVP와 꽤 비슷하다
	- MVVM은 View Controller를 View라고 일컫는다.
	- View와 Model이 서로 연결 되어있지 않다.

- 실제 iOS에서 View Model이 뭘 의미할까?
	- View Model은 Model에서 변경을 호출하고 Model 자체를 갱신한다. 
	- 따라서 View나 View Model 사이에서 바인딩을 하며, 적절히 처음것이 갱신된다.


- 바인딩이 필요
	- 사실 요즘엔 MVVM을 들으면 바로 RxSwift를 말하는편.
	- 비록 간단한 바인딩으로 MVVM을 만드는게 가능하기는 하나 RxSwift으로는 최고의 MVVM을 만들수 있게 해준다.

- Reactive 프레임워크에는 쓰디쓴 진실이 하나 있다: 
	- 큰 책임엔 큰 에너지가 필요하다. 
	- Reactive를 사용하게되면 굉장히 혼잡해지기 쉬워진다. 
	- 다른말로 설명하자면, 문제가 하나 생기면 앱을 디버깅하는데 시간이 굉장히 많이 걸린다.

```swift
import UIKit

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol: class {
    var greeting: String? { get }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? { get set } // function to call when greeting did change
    init(person: Person)
    func showGreeting()
}

class GreetingViewModel : GreetingViewModelProtocol {
    let person: Person
    var greeting: String? {
        didSet {
            self.greetingDidChange?(self)
        }
    }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?
    required init(person: Person) {
        self.person = person
    }
    func showGreeting() {
        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
}

class GreetingViewController : UIViewController {
    var viewModel: GreetingViewModelProtocol! {
        didSet {
            self.viewModel.greetingDidChange = { [unowned self] viewModel in
                self.greetingLabel.text = viewModel.greeting
            }
        }
    }
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self.viewModel, action: "showGreeting", forControlEvents: .TouchUpInside)
    }
    // layout code goes here
}
// Assembling of MVVM
let model = Person(firstName: "David", lastName: "Blaine")
let viewModel = GreetingViewModel(person: model)
let view = GreetingViewController()
view.viewModel = viewModel
```

- Distribution
	- 우리의 작은 예제에서는 명료하게 나타나지 않았지만, 사실 MVVM의 View는 MVP의 View보다 더 책임이 많다. 
	- 왜냐면 두번째 것이 Presenter로 포워드(forward)하고 그 자신를 갱신 하지는 않은 그 때, 바인딩을 세팅함으로써 View Model에서 처음 것의 상태를 갱신한다.
- Testability
	- View Model은 View에대해 전혀 모르며, 이것이 테스트하기 쉽게 해준다. 
	- View 또한 테스트 가능하지만 UIKit 의존이면 그러고 싶지 않게 원하게 될것이다.
- Easy of use
	- 우리 예제에서는 MVP와 비슷한 양의 코드나 나왔으나 View에서 Presenter으로 모든 이벤트를 포워드하고 View를 갱신하는 실제 앱에선 바인딩을 사용했다면 MVVM의 코드 양이 더 적을 것 이다.


- MVVM은 앞에서 말한 장점들을 합쳐놓은것 같아서 굉장히 매력적이다. 
- 그리고 View입장에서 바인딩을 하기 때문에 View를 갱신하는데 추가적인 코드를 필요로 하지도 않는다. 
- 그럼에도 불구하고 테스트에도 굉장히 좋은 수준이다.


## VIPER
- Interactor
	- 데이터 개체나 네트워킹과 연관되어있는 비지니스 로직을 가지고, 서버로부터 그들을 받아오거나 새 개체 인스턴스를 만드는것을 좋아한다. 
	- 이러한 목적으로을 위해서 당신은 VIPER 모듈의 일부로써 몇몇 Services와 Managers를 사용해야 할 것이나, 다소 외부 의존도가 있을것이다.
- Presenter
	- Interactor에서 발생되고 비지니스 로직과 관련있는 (그러나 UIKit과는 관련없는) UI를 가진다.
- Entities
	- 일반적인 데이터 객체이다. (데이터 접근 레이어(data access layer)는 Interactor의 책임이기 때문에 Entities는 아니다.)
- Router
	- VIPER 모듈 사이의 연결고리(seques) 책임을 가진다.
기본적으로 VIPER 모듈은 한 스크린(screen)이나 당신 어플리케이션의 모든 ***사용자 스토리(user story)가 될 수 있다—인증을 생각해보면 한 스크린이나 여러개가 하나에 연관되어 있을 수 있다. 얼마나 작은 “LEGO” 블럭어여야 할까?—전적으로 당신에게 달려있다.



- MV(X) 종류와 비교하면, 우리는 책임의 분리가 좀 다르다는걸 확인할 수 있다:
	- Model(data interation) 로직은 빈 데이터 구조로써 Entities와 함께 Interactor에 이동된다.
	- 오직 Controller/Presenter/ViewModel이 Presenter로 이동하는 UI 표시 책임을 갖지만, 데이터를 변경할 능력은 없다.
	- VIPER는 명시적으로 Router에의해 결정된 네비게이션 책임을 해결한 첫 패턴이다. 
	- iOS 어플리케이션 입장에서는 각기 방법으로 라우팅 하는게 도전이라고 할 수있다. 
	- MV(X) 패턴들은 이러한 이슈가 발생하지 않는다.


- Distribution 
	- 틀림없이 VIPER는 책임 분배의 최고봉이다.
- Testability
	- 분리가 잘되있는만큼 테스트에도 좋다.
- Easy of use 
	- 마지막으로 여러분이 이미 추측한것처럼 두배 정도의 유지보수 비용이 들것이다. 
	- 매우 작은 책임을 위해 수많은 클래스 인터페이스를 작성해야하는 점이다.


##결론
우리는 몇몇 다른 아키텍처 패턴을 살펴보았고, 무엇이 당신을 괴롭히는지 찾아냈기를 바란다. 
그러나 여기에 완벽한 해답은 없고 아키텍처를 선택하는게 당신의 특별한 상황에서 문제의 비중을 등가교환하게 된다는걸 알게되었음을 의심하지 않는다. 

그러므로 한 앱에 다른 아키텍처를 섞어 사용하는것은 자연스러운 일이다. 
예를들어 MVC로 시작했지만 어떤 한 화면에서만 MVC로 관리하기 어려워지는 상황이 생기면 그 부분만 MVVM으로 바꿀 수 있다. 
이런 아키텍처들은 서로 잘 공존할 수 있기때문에, 다른 화면이 MVC 골격으로 잘 동작하면 바꿀 필요가 없다. 



