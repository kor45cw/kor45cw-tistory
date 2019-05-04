# Swinject in practice

- 내 생각에 너는 이미 의존성 주입에 대해 들어봤을 것 같다. 
- Dependency Injection(DI)은 의존성 해결을 위한 Control Inversion을 실행하는 소프트웨어 설계 패턴이다. 
- iOS에서는 Dependency injection에 사용할 수 있는 인기 있는 프레임워크 중 하나가 Swinject이다. 
- 오늘 우리는 당신이 직면했을지도 모르는 두 가지 에지 사례, 즉 맞춤 객체 범위와 도메인별 조립품에 초점을 맞추기 위해 당신의 앱에서 Swinject를 사용하는 기본 사항을 빠르게 다룰 것이다. 

## The basics

- Swinject를 사용하면 종속성을 `assemblies`라고 하는 논리 관련 객체로 분할할 수 있습니다. 
- 예를 들어, 도우미 의존성을 거의 등록하지 않는 `HelperAssembly`를 만들어서 프로젝트에서 필요한 것을 만들어 보자.

```swift
class HelperAssembly: Assembly {

    func assemble(container: Container) {

        container.register(UIApplication.self) { _ in
            UIApplication.shared
        }

        container.register(UserDefaults.self) { _ in
            UserDefaults.standard
        }

        container.register(Bundle.self) { _ in
            Bundle.main
        }

        container.register(FileManager.self) { _ in
            FileManager.default
        }

        ...
    }
}
```

- Swinject는 다른 DI 프레임워크와 마찬가지로 키 밸류 스토어(여기에 이름 붙여진 컨테이너)처럼 동작한다. 
- 키는 유형(프로토콜이나 클래스나 구조를 가진 콘크리트와 함께 추상화)이며 그러한 유형의 값 인스턴스(instance)이다. 
- 일단 낮은 수준의 의존성이 등록되면, 우리는 그것들을 더 높은 수준의 의존성으로 사용하기 시작할 수 있다. 
	- 우리 앱에서 마지막으로 본 제품의 목록을 가져와야 한다고 합시다. 
	- 우리는 인터페이스(스위프트의 프로토콜)와 이 인터페이스의 구체적인 구현을 만든다.


```swift
// the interface
protocol LastViewedProductsRepository {
    ...
    func items() -> [Product]
}

// the implementation
class LastViewedProductsRepositoryImplementation: LastViewedProductsRepository {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: - LastViewedProductsRepository

    func items() -> [Product] {
        // retrieve products from the userDefaults
    }
}


class RepositoryAssembly: Assembly {

    func assemble(container: Container) {

        // We register the abstract type as a key ...
        container.register(LastViewedProductsRepository.self) { r in
            // ... and a concrete implementation instance as a value
            LastViewedProductsRepositoryImplementation(
                // we don't know how to retrieve a userDefault,
                // we just expect Swinject to give us one at runtime
                userDefaults: r.resolve(UserDefaults.self)!
            )
        }.inObjectScope(.container)

        ...
    }
}
```

- LastViewedProductsRepository는 UserDefault의 인스턴스를 사용하여 응용 프로그램에서 마지막으로 본 제품을 저장한다. 
- 이 의존성은 HelperAssembly를 사용하여 런타임에 해결될 것이다. 
- 여기에서 객체 범위 컨테이너를 사용하여 전체 응용프로그램에서 LastViewedProductsRepositoryImplementation의 단일 인스턴스를 생성한다. 
- 여기서 더 자세히 설명할 수 있는 범위가 몇 개 있다. 
- 마지막에 우리는 모든 조립품을 조립자로 모아서 의존성을 만들기 위해 사용한다.

```swift
class DependencyProvider {

    let container = Container()
    let assembler: Assembler

    init() {
        // the assembler gathers all the dependencies in one place
        assembler = Assembler(
            [
                HelperAssembly(),     // from low
                RepositoryAssembly(), // ...
                PresenterAssembly(),  // to high level
            ],
            container: container
        )
    }

    ...
}
```

## Custom object scopes

- 앞에서 우리는 마지막으로 본 제품의 캐시를 앱에 보관하는 LastViewed Products Repository 개체를 보았다. 
- 현재는 어셈블리에서 컨테이너 범위를 사용했기 때문에 전체 응용 프로그램에이 클래스의 단일 인스턴스가 있습니다. 
- 그리고 슬프게도, 이 인스턴스는 사용자가 로그아웃하더라도 동일합니다. 그리고 다른 ID로 로그인합니다.

- 그건 버그입니다. 
	- 현재 사용자가 로그아웃할 때 마지막으로 본 모든 제품을 지우고 싶습니다. 
	- 이를 극복하기 위해 우리는 몇 가지 옵션을 가지고 있습니다. 
	- 사용자가 로그아웃하고 리포지토리에서 이 알림을 들을 때 알림을 내보냅니다 LastViewedProducts Repository에서 제품 (예 : cleanyCache)을 청소하고 사용자가 로그 아웃할 때 외부에서 호출하는 공개 방법을 제공합니다. 
	- 이 두 가지 선택은 훌륭하지만 확장이 쉽지 않다. 
	- 우리는 이 논리를 DI로 추방하고 싶습니다. 
		- 즉, 다음과 같은 객체에 대한 범위를 만듭니다. 
		- 사용자가 로그인하는 동안 인스턴스를 계속 유지합니다. 
		- 사용자가 로그아웃할 때 인스턴스를 휴지통으로 만듭니다.
		- 새 사용자가 로그인할 때 새 인스턴스를 만듭니다.

discardedWhenLogout이라는 이름의 새로운 개체 범위를 생성하자.

```swift
extension ObjectScope {
    static let discardedWhenLogout = ObjectScope(
        storageFactory: PermanentStorage.init,
        description: "discardedWhenLogout"
    )
}
```

- We can use it in our assembly instead of the container scope:

```swift
class RepositoryAssembly: Assembly {

    func assemble(container: Container) {

        container.register(LastViewedProductsRepository.self) { r in
            LastViewedProductsRepositoryImplementation(
                userDefaults: r.resolve(UserDefaults.self)!
            )
        }.inObjectScope(.discardedWhenLogout) // we replace the container scope

        ...
    }
}
```

- 이제 우리는 Swinject 메소드 resetObjectScope(_ objectScope: ObjectScope)를 컨테이너에 사용할 수 있다. 
- 이 방법은 주어진 오브젝트 범위에 등록된 모든 인스턴스를 삭제한다. 
- 그것은 모든 사례들이 다시 한번 필요하게 되면 다시 만들어질 것이라는 것을 의미한다.

```swift
func userDidLogout() {
    let container = ... // get the container somehow
    container.resetObjectScope(.discardedWhenLogout)
}
```

- Now the next time a user logs in, all the last viewed products will be cleared.

## Domain specific assemblies

- 경우에 따라 일부 값이 다운로드되거나 앱의 다른 곳에 설정되는 경우에만 액세스할 수 있는 부분이 있다. 
- 우리의 경우, 사용자가 로그인할 때 다운로드되는 구성 파일이 있고, 이 구성이 앱의 나머지 부분에서 집중적으로 사용된다고 가정해 보자. 
- 이 구성 파일은 LoginConfiguration 객체에 매핑되는데, 이것은 단지 많은 속성을 가진 구조일 뿐이다. 
- 우리 어플리케이션의 마지막 조회된 제품 페이지에서, 표시되는 제품의 수는 구성의 maxproducts 값으로 제한된다.
- 여기서는 LastViewedProductsPresenter의 클래스를 보여주는데, 발표자는 ViewController와 비슷하지만 UIKit에 얽매이지 않는다는 것을 명심하라.

```swift
class LastViewedProductsPresenterImplementation: LastViewedProductsPresenter {

    ...
    // repository to get the last viewed products
    private let lastViewedProductsRepository: LastViewedProductsRepository
    // repository to get the saved configuration
    private let loginConfigurationRepository: LoginConfigurationRepository

    init(lastViewedProductsRepository: LastViewedProductsRepository,
         loginConfigurationRepository: LoginConfigurationRepository) {
        self.lastViewedProductsRepository = lastViewedProductsRepository
        self.loginConfigurationRepository = loginConfigurationRepository
    }

    // MARK: - LastViewedProductsPresenter

    // method called when we want to reload the UI
    func reload() {
        guard let loginConfiguration = loginConfigurationRepository.savedConfiguration() else {
            return
        }
        let items = min(
            lastViewedProductsRepository.items(),
            loginConfiguration.maxProducts
        )
        // display items somehow
    }

    ...

}
```

- 여기서 문제는 사용자가 이 페이지에 액세스하기 위해 로그인해야 하기 때문에 이 경우 구성을 사용할 수 있어야 함에도 불구하고 우리가 loginConfiguration을 경계한다는 것이다. 
- 그러나 loginConfigurationRepository는 선택사항(사용자가 로그인하기 전에는 구성이 존재하지 않음)을 반환합니다. 
- 그러나 생각해 보면 올바른 해결책이 아니다. 
- 발표자 객체를 리포지토리로 초기화하지 않고, 우리는 loginConfiguration으로 직접 초기화해야 한다. 
- 왜냐하면 우리는 이 시점에서 그러한 값이 존재한다는 것을 확신하기 때문이다.
- LastViewedProductsPresenterImplementation은 두 가지 종속성을 가지고 있으므로, PresenterAssembly는 다음과 같이 보인다.

```swift
class PresenterAssembly: Assembly {

    func assemble(container: Container) {

        container.register(LastViewedProductsPresenter.self) { r in
            LastViewedProductsPresenterImplementation(
                lastViewedProductsRepository: r.resolve(LastViewedProductsRepository.self)!,
                loginConfigurationRepository: r.resolve(LoginConfigurationRepository.self)!
            )
        }

        ...
    }
}
```

- 우리가 원하는 것은 loginConfigurationRepository 대신 init time에 initialer에게 loginConfiguration을 전달하는 것이다. 
- 그것은 우리가 loginConfiguration을 어셈블리 자체에 저장해야 종속성을 해결할 수 있다는 것을 의미한다.
- LoggedInPresenterAssembly라는 새로운 어셈블리를 정의하자. 
- 이 어셈블리는 사용자가 로그인한 후에만 사용할 유형을 등록한다. 
	- 사용자가 로그인할 때, 우리는 로그인 구성이 확보되어 어셈블리에서 사용 가능한 것으로 가정할 수 있다.

```swift
class LoggedInPresenterAssembly: Assembly {

    // we store the configuration directly
    private let loginConfiguration: LoginConfiguration

    init(loginConfiguration: LoginConfiguration) {
        self.loginConfiguration = loginConfiguration
    }

    func assemble(container: Container) {

        container.register(LastViewedProductsPresenter.self) { r in
            LastViewedProductsPresenterImplementation(
                lastViewedProductsRepository: r.resolve(LastViewedProductsRepository.self)!,
                // and pass it instead of the loginConfigurationRepository
                loginConfiguration: loginConfiguration
            )
        }

        ...
    }
}
```

- 지금 해야 할 일은 사용자가 로그인할 때 LoggedInPresenterAssembly를 생성하고 구성을 가져와 조립자에게 주는 것이다.

```swift
func userDidLogin(with configuration: LoginConfiguration) {
    let assembly = LoggedInPresenterAssembly(loginConfiguration: configuration)
    let assembler = ... // get the assembler somehow
    assembler.apply(assembly)
    ...
}
```

- That way the presenter now becomes:

```swift
class LastViewedProductsPresenterImplementation: LastViewedProductsPresenter {

    ...
    private let lastViewedProductsRepository: LastViewedProductsRepository
    // we can use the configuration directly
    private let loginConfiguration: LoginConfiguration

    init(lastViewedProductsRepository: LastViewedProductsRepository,
         loginConfiguration: LoginConfiguration) {
        self.lastViewedProductsRepository = lastViewedProductsRepository
        self.loginConfiguration = loginConfiguration
    }

    // MARK: - LastViewedProductsPresenter

    func reload() {
        // note that the guard is gone!
        let items = min(
            lastViewedProductsRepository.items(),
            loginConfiguration.maxProducts
        )
        // display items somehow
    }

    ...

}
```

## Wrap up
- 종속성 주입은 코드를 재사용하고 테스트할 수 있도록 프로그래밍의 주요 개념입니다. 
- 이 블로그 게시물에 설명된 개념은 프레임 워크 및 플랫폼과 독립적으로 적용될 수 있습니다. 
- 특히, 우리는 두 가지 고급 사용 사례를 보았습니다. 
	- 종속성의 수명을 사용자 정의하기 위한 사용자 지정 개체 범위 일부 외부 요구사항에 따라 종속성을 작성하는 도메인별 표준횡단을 작성합니다
