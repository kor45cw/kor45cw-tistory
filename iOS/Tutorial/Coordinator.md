# Coordinator

- Horizontal Flow
	- NavigationController를 사용하여 ViewController를 Push 할 때
- Vertical Flow
	- ViewController를 Present 할 때 
	- NavigationController를 Present 해도 수직흐름이다.

- Segue
	- 아마도 모든 사람들이 iOS를 개발하기 시작할 때 사용한 첫 번째 모드일 것이다. 
	- 그것은 navigating 할 때 심각한 제한이 있고 흐름을 통제하기 위한 많은 결점이 있다. 
	- 가능하면 항상 피해야 한다.
- Directly
	- 일반적으로 Segue 한계를 배운 후, push를 사용하기 시작하고 ViewController에서 직접 표시. 
	- 탐색할 때 한계가 있지만 스토리보드에 없는 ViewController의 초기화를 지원한다. 
	- 이 옵션은 언제 라우팅 되는지 잊기 쉽기 때문에, 단지 몇 개의 화면만 있는 어플리케이션이 있을 때 괜찮다.
- Router
	- 보통 사람들은 라우팅을 ViewControllers, ViewModels들에서 하고 그것들을 Router안에서 관리하지 않는다.
	- 이 옵션은 올바르게 사용된다면 매우 강력할 수 있다.


```swift
protocol Coordinator: AnyObject {
  func start()
}

import UIKit

final class ExampleCoordinator {
  private var childCoordinators: [Coordinator] = []
  private let presenter: UIViewController
  
  init(presenter: UIViewController) {
    self.presenter = presenter
  }
}

extension ExampleCoordinator: Coordinator {
  func start() {
    let firstViewModel = FirstViewModel(navigationDelegate: self)
    let firstViewController = FirstViewController(viewModel: firstViewModel)
    
    presenter.present(firstViewController, animated: true)
  }
}

import UIKit

final class FirstViewController: UIViewController {
  private let viewModel: FirstViewModel
  
  init(viewModel: FirstViewModel) {
    self.viewModel = viewModel
    
    ...
  }
 
  @IBAction private func action() {
    viewModel.onAction()
  }
}

protocol FirstSceneNavigationDelegate() {
  func onNavigate()
}

final class FirstViewModel {
  private weak var navigationDelegate: FirstSceneNavigationDelegate?
  
  init(navigationDelegate: FirstSceneNavigationDelegate?) {
    self.navigationDelegate = navigationDelegate
  }
  
  func onAction() {
    navigationDelegate?.onNavigate()
  }
}

// MARK: - FirstViewModelNavigationDelegate
extension ExampleCoordinator: FirstSceneNavigationDelegate() {
  func onNavigate() {
    let secondViewModel(navigationDelegate: self)
    let secondViewController(viewModel: secondViewModel)
    
    presenter.pushViewController(secondViewController, animated: true)
  }
}

final class PrivateNavigationCoordinator {
    private let presenter: UIViewController
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        // customize the navigation controller
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.tintColor = .black
        
        let attributedStrings = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)
        ]
        
        navigationController.navigationBar.titleTextAttributes = attributedStrings
        
        return navigationController
    }()
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    deinit {
        //do something if needed
    }
}

// MARK: - Coordinator
extension PrivateNavigationCoordinator: Coordinator {
    func start() {
        let firstViewModel = FirstViewModel(navigationDelegate: self)
        let firstViewController = ProfileViewController(viewModel: firstViewModel)
        
        navigationController.pushViewController(firstViewController, animated: true)
        
        presenter.present(navigationController, animated: true)
    }
}

// MARK: - SecondSceneNavigationDelegate
extension ExampleCoordinator: SecondSceneNavigationDelegate {
    func onNavigateToNewFlow() {
        let privateNavigationCoordinator = PrivateNavigationCoordinator(presenter: presenter)
        childCoordinators.append(profileCoordinator)
        
        profileCoordinator.start()
    }
}
```


## Dismiss

```swift

protocol CoordinatorFinishFlowDelegate: AnyObject {
  func onFinish<T: Deliverable>(item: T?, coordinator: Coordinator)
}

protocol CoordinatorFinishFlowCompletionBlock: AnyObject {
  associatedtype deliverableType
  var onFinish: ((deliverableType) -> ())? { get set }
}

extension ExampleCoordinator: CoordinatorFinishFlowDelegate {
    func onFinish<T: Deliverable>(item: T?, coordinator: Coordinator) {
        // do something with the item
        ...
        // dealloc dismissed coordinator
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
```

## AppDelegate

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()
        
        return true
    }   
}
```