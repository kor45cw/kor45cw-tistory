# Keychain Services API Tutorial for Passwords in Swift

- 왜 키체인을 사용하는가? 
	- 어차피 Userdefaults에 저장하는 것도 base64 encoding 하지않는가?
	- 하지만 공격자가 그런것을 복구하는 것은 어려운 일이 아니다.
	- 키체인은 사용자를 대신해 암호화된 Database에 Item 또는 작은 데이터 덩어리를 안전하게 저장할 수 있게 도와준다.

- Apple의 문서에서 `SecKeychain` 클래스는 데이터베이스를 나타내고 `SecKeychainItem` 클래스는 Item을 나타냅니다.

- 키체인은 운영체제에 따라 다르게 작동한다.
	- iOS는 iCloud 키체인을 포함하는 단일 키체인에 접근한다.
		- 앱은 자신의 item이나 자신이 속한 그룹과 공유하는 항목에만 접근 가능하다.
	- macOS는 여러개의 키체인을 지원한다.
		- 일반적으로 `Keychain Access` 앱으로 이것들을 관리한다. 
		- 직접 조작할 수 있다.


- 암호 등의 비밀을 저장하고 싶을 때는 키체인 item으로 패키징한다. 
	- 이것은 Data와 Attribute 집합의 두 부분으로 구성된 불투명한 유형이다. 
	- 그것이 새로운 item을 삽입하기 직전에, Keychain Services는 데이터를 암호화한 다음 그것의 속성과 함께 그것을 포장한다.
- Attribute을 사용해서 메타데이터를 식별하고 저장하거나 저장된 항목에 대한 액세스를 제어한다. 
	- CFD사전으로 표현되는 사전의 키와 값으로 속성을 지정한다. 
	- 사용 가능한 키의 목록은 Item Attribute Keys and Values에서 찾을 수 있다. 
	- 해당하는 값은 문자열, 숫자, 기타 기본적인 유형 또는 보안 프레임워크와 함께 패키징된 상수가 될 수 있다.

- 키 체인 서비스는 특정 항목에 대한 클래스를 식별할 수 있는 특수한 종류의 속성을 제공합니다. 
- 이 튜토리얼에서는 `kSecClassGenericPassword`와 `kSecClassInternetPassword`를 모두 사용하여 일반 및 인터넷 암호를 처리합니다. 
	- 각 클래스는 특수한 속성 집합만 지원합니다. 즉, 모든 속성이 특정 항목 클래스에 적용되는 것은 아닙니다. 
	- 관련 항목 클래스 값 문서에서 해당 항목을 확인할 수 있습니다.

> 암호 조작 외에도 Apple은 인증서, 암호화 키 및 ID와 같은 다른 유형의 항목과 상호 작용할 수 있는 기회를 제공합니다. 이들은 각각 `kSecClassCertificate`, `kSecClassKey` 및 `kSecClassIdentity` 클래스로 표시됩니다.


## Diving Into Keychain Services API
- 코드는 의도하지 않은 사용자로부터 항목을 숨기기 때문에, Keychain Services는 상호작용을 위한 일련의 C 기능을 제공한다. 
- 일반 비밀번호와 인터넷 비밀번호를 모두 조작하는 데 사용할 API는 다음과 같다. 
	- `SecItemAdd(_:_:)`: 키체인에 하나 이상의 항목을 추가할 때 이 기능을 사용한다.
	- `SecItemCopyMatching(_:_:)`: 검색 쿼리와 일치하는 키체인 항목을 하나 이상 반환하는 기능입니다. 또한 특정 키 체인 항목의 속성을 복사할 수 있다. 
	- `SecItemUpdate(_:_::)`: 검색 쿼리와 일치하는 항목을 수정할 수 있는 기능입니다. 
	- `SecItemDelete(_:)`: 검색 쿼리와 일치하는 항목을 제거하는 기능입니다. 
	- 위의 기능은 서로 다른 파라미터로 동작하지만, 모두 OSStatus로 표현된 결과 코드를 반환한다. 
	- 이것은 32비트 부호 정수로, Item Return Result Keys에 열거된 값 중 하나를 가정할 수 있다.

- OSStatus가 이해하기 어려울 수 있기 때문에, 
	- 애플은 `SecCopyErrorMessageString(_:_:)`이라는 API를 추가로 제공하여 이러한 상태 코드에 해당하는 사람이 읽을 수 있는 문자열을 획득한다.

> 참고 : 특정 키 체인 항목을 추가, 수정, 삭제 또는 검색하는 것 외에도 Apple은 내보내기 및 가져 오기 인증서, 키 및 ID 모두에 기능을 제공하거나 항목의 액세스 제어를 수정합니다. 더 많은 것을 알고 싶으면 키 체인 항목에 대한 문서를 확인하십시오.

- 이제 Keychain Services에 대해 확실하게 이해하셨으니, 다음 섹션에서는 포장지에 의해 제공된 뭉툭한 방법을 제거하는 방법에 대해 알아보실 겁니다.


## Implementing Wrapper’s API
- Open SecureStore.swift and add the following implementation inside setValue(_:for:):

```swift
// 1
guard let encodedPassword = value.data(using: .utf8) else {
  throw SecureStoreError.string2DataConversionError
}

// 2
var query = secureStoreQueryable.query
query[String(kSecAttrAccount)] = userAccount

// 3
var status = SecItemCopyMatching(query as CFDictionary, nil)
switch status {
// 4
case errSecSuccess:
  var attributesToUpdate: [String: Any] = [:]
  attributesToUpdate[String(kSecValueData)] = encodedPassword
  
  status = SecItemUpdate(query as CFDictionary,
                         attributesToUpdate as CFDictionary)
  if status != errSecSuccess {
    throw error(from: status)
  }
// 5
case errSecItemNotFound:
  query[String(kSecValueData)] = encodedPassword
  
  status = SecItemAdd(query as CFDictionary, nil)
  if status != errSecSuccess {
    throw error(from: status)
  }
default:
  throw error(from: status)
}
```


- 이름에서 알 수 있듯이 이 방법을 사용하면 특정 계정에 대한 새 암호를 저장할 수 있습니다. 
- 암호를 업데이트하거나 추가할 수 없는 경우 보안 저장소 오류를 실행하지 않는 오류가 발생하여 해당 암호에 대한 현지화된 설명을 지정합니다.

- 다음은 코드가하는 것입니다. 
	1. 데이터 유형에 저장할 값을 인코딩할 수 있는지 확인합니다. 그것이 불가능하다면, 변환 오류가 발생한다. 
	2. 쿼리가 원하는 계정을 실행하고 추가할 수 있는지 보안 저장 가능한 인스턴스에 문의하십시오. 
	3. 쿼리와 일치하는 키 체인 항목을 반환합니다. 
	4. 쿼리가 성공하면 해당 계정에 대한 암호가 이미 존재합니다. 이 경우 SecItemUpdate (_ : :)를 사용하여 기존 암호의 값을 대체합니다. 
	5. 항목을 찾을 수 없는 경우 해당 계정의 암호가 아직 존재하지 않습니다. SecItemAdd (_ : :)를 호출하여 항목을 추가합니다.


- Keychain Services API는 Core Foundation 타입을 사용한다.
- 컴파일러를 행복하게 하려면 코어 파운데이션 타입에서 스위프트 타입으로, 그 반대로 전환해야 한다. 첫
-  번째 경우, 각 키의 속성이 CFString 형식이기 때문에 쿼리 사전에서 키로서의 용도는 String에 대한 캐스팅을 요구한다. 그러나 [String: Any]에서 CFDictionary로 변환하면 C 기능을 호출할 수 있다. 
-  이제 너의 비밀번호를 되찾을 시간이다. 방금 구현한 방법 아래로 스크롤하여 getValue(for:)의 구현을 다음과 같이 대체한다.

```swift
// 1
var query = secureStoreQueryable.query
query[String(kSecMatchLimit)] = kSecMatchLimitOne
query[String(kSecReturnAttributes)] = kCFBooleanTrue
query[String(kSecReturnData)] = kCFBooleanTrue
query[String(kSecAttrAccount)] = userAccount

// 2
var queryResult: AnyObject?
let status = withUnsafeMutablePointer(to: &queryResult) {
  SecItemCopyMatching(query as CFDictionary, $0)
}

switch status {
// 3
case errSecSuccess:
  guard 
    let queriedItem = queryResult as? [String: Any],
    let passwordData = queriedItem[String(kSecValueData)] as? Data,
    let password = String(data: passwordData, encoding: .utf8)
    else {
      throw SecureStoreError.data2StringConversionError
  }
  return password
// 4
case errSecItemNotFound:
  return nil
default:
  throw error(from: status)
}
```

- 특정 계정을 지정하면, 이 방법은 그것과 관련된 암호를 검색한다. 
- 다시 한번, 요청에 문제가 발생하면 코드는 SecureStoreError.unhandledError를 던진다.

- 방금 추가한 코드에 대한 내용은 다음과 같다.
	1. `secureStoreQueryable`에게 쿼리를 실행하도록 요청한다. 당신이 관심 있는 계정을 추가하는 것 외에, 이것은 다른 속성들과 그들의 관련 가치들로 질의에 활력을 준다. 특히, 단일 결과를 반환하고, 그 특정 항목과 관련된 모든 속성을 반환하고, 그 결과 암호화되지 않은 데이터를 반환하도록 요구하는 것이다.
	2. 검색을 수행하려면 `SecItemCopyMatching(_:_:)`을 사용한다. `queryResult`는 가능한 경우 완료 시 발견된 항목에 대한 참조를 포함한다. `withUnsafeMonablePointer(to:_:)`는 결과를 저장하기 위해 폐쇄 내에서 사용하고 수정할 수 있는 `UnsafeMonablePointer`에 대한 액세스를 제공한다.
	3. 쿼리가 성공하면 아이템을 찾았다는 뜻이다. 그 결과는 당신이 요청한 모든 속성을 포함하는 사전으로 대표되므로, 당신은 먼저 데이터를 추출한 다음 그것을 데이터 유형으로 디코딩해야 한다.
	4. item을 찾을 수 없으면 nil값을 반환한다.

- 계정에 암호를 추가하거나 검색하는 것으로는 충분하지 않습니다. 암호를 제거하는 방법도 통합해야 합니다.
- `removeValue(for:)`을 찾아 구현을 추가하십시오.

```swift
var query = secureStoreQueryable.query
query[String(kSecAttrAccount)] = userAccount

let status = SecItemDelete(query as CFDictionary)
guard status == errSecSuccess || status == errSecItemNotFound else {
  throw error(from: status)
}
```

- 암호를 제거하려면 찾고 있는 계정을 지정하는 `SecItemDelete(_ :)`를 수행합니다. 
- 암호를 성공적으로 삭제했거나 항목이 없는 경우 작업을 완료하고 보석금을 내십시오. 
- 그렇지 않으면 사용자가 잘못되었음을 알리기 위해 처리되지 않은 오류를 발생시킵니다.
- 하지만 특정 서비스와 관련된 모든 암호를 제거하려면 어떻게 해야 할까? 다음 단계는 이 작업을 수행하기 위한 최종 코드를 구현하는 것입니다.
- `removeAllValues()`를 찾아 괄호 안에 다음 코드를 추가하십시오.

```swift
let query = secureStoreQueryable.query
  
let status = SecItemDelete(query as CFDictionary)
guard status == errSecSuccess || status == errSecItemNotFound else {
  throw error(from: status)
}
```

- 보시다시피, 이 방법은 `SecItemDelete(_:)`함수에 전달된 쿼리를 제외하면 이전 방법과 유사하다. 
- 이 경우 사용자 계정과 독립적으로 암호를 제거한다.
- 마지막으로, 모든 컴파일을 정확하게 검증할 수 있는 프레임워크를 구축한다.


## Connecting the Dots
- 지금까지 당신이 한 모든 작업은 당신의 포장지에 추가, 업데이트, 삭제, 검색 기능을 부여한다. 
- 현재와 마찬가지로, 당신은 `SecureStoreQueryable`에 부합하는 어떤 유형의 인스턴스로 래퍼를 만들어야 한다.
- 여러분의 첫 번째 목표는 일반 비밀번호와 인터넷 비밀번호 모두를 다루는 것이었기 때문에, 다음 단계는 소비자가 만들고 여러분의 랩퍼에 주입할 수 있는 두 가지 다른 구성을 만드는 것이다.
- 먼저, 일반 비밀번호에 대한 쿼리를 구성하는 방법을 검토한다.
	- `SecureStoreQueryable.swift`를 열고 `SecureStoreQueryable` 정의 아래에 다음 코드를 추가한다.

```swift
public struct GenericPasswordQueryable {
  let service: String
  let accessGroup: String?
  
  init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}
```

- `GenericPasswordQueryable`은 서비스와 액세스 그룹을 String 매개 변수로 받아들이는 간단한 구조입니다.
- 다음으로, `GenericPasswordQueryable` 정의 아래에 다음 확장을 추가하십시오.

```swift
extension GenericPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    // Access group if target environment is not simulator
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}
```

- `SecureStoreQueryable`프로토콜을 준수하기 위해, 당신은 속성으로서 쿼리를 구현해야 한다. 
- 쿼리는 당신의 포장지가 선택한 기능을 수행할 수 있는 방법을 나타낸다.
- 구성된 쿼리는 다음과 같은 구체적인 키와 값을 가지고 있다.
	1. 키 `kSecClass`로 대표되는 항목 클래스는 일반 암호를 다루고 있기 때문에 `kSecClassGenericPassword` 값이 있다. keychain은 데이터가 비밀이라는 것을 어떻게 주입하고 있으며, 암호화가 필요하다.
	2. `kSecAttrService`는 `GenericPasswordQueryable`의 새로운 인스턴스와 함께 주입되는 서비스 파라미터 값으로 설정된다.
	3. 마지막으로, 당신의 코드가 시뮬레이터에서 실행되고 있지 않으면 `kSecAttrAccessGroup` 키도 제공된 `accessGroup` 값으로 설정한다. 이를 통해 동일한 액세스 그룹과 서로 다른 앱 간에 항목을 공유할 수 있다.

- 다음으로 모든 것이 올바르게 작동하도록 프레임워크를 구축합니다.

> 참고 : 클래스 `kSecClassGenericPassword`의 키 체인 항목의 경우 기본 키는 `kSecAttrAccunt`와 `kSecAttrService`의 조합입니다. 
> 다시 말해 튜플을 사용하면 키 체인에서 일반 암호를 고유하게 식별할 수 있습니다.
 
- 너의 반짝이는 새 포장지는 아직 완성되지 않았어! 
- 다음 단계는 소비자가 인터넷 암호와 상호 작용할 수 있는 기능을 통합하는 것입니다.
- `SecureStoreQueryable.swift`의 끝까지 스크롤하고 다음을 추가하십시오.

```swift
public struct InternetPasswordQueryable {
  let server: String
  let port: Int
  let path: String
  let securityDomain: String
  let internetProtocol: InternetProtocol
  let internetAuthenticationType: InternetAuthenticationType
}
```

- InternetPasswordQueryable은 응용 프로그램 키 체인 내에서 인터넷 암호를 조작하는 데 도움이 되는 구조입니다.
- SecureStoreQueryable을 준수하기 전에 잠시 API가 이 경우 어떻게 작동하는지 이해하십시오.
- 사용자가 인터넷 암호를 처리하고자하는 경우 InternetProtocol 및 InternetAuthenticationType 속성이 특정 도메인에 바인딩되는 InternetPasswordQueryable의 새로운 인스턴스를 만듭니다.
- 다음으로, 인터넷 암호 쿼리 가능한 구현 아래에 다음을 추가하십시오.

```swift
extension InternetPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassInternetPassword
    query[String(kSecAttrPort)] = port
    query[String(kSecAttrServer)] = server
    query[String(kSecAttrSecurityDomain)] = securityDomain
    query[String(kSecAttrPath)] = path
    query[String(kSecAttrProtocol)] = internetProtocol.rawValue
    query[String(kSecAttrAuthenticationType)] = internetAuthenticationType.rawValue
    return query
  }
}
```

- 일반적인 암호 사례에서 보듯이 쿼리는 다음과 같은 구체적인 키와 값을 가지고 있다.
- 키 kSecClass로 대표되는 항목 클래스는 이제 인터넷 암호와 상호 작용하므로 kSecClassInternetPassword 값을 가지고 있다.
- kSecAttrPort는 포트 파라미터로 설정된다.
- kSecAttrServer는 서버 파라미터로 설정된다.
- kSecurityAttrSecurityDomain은 securityDomain 매개 변수로 설정된다.
- kSecAttrPath는 경로 파라미터로 설정된다.
- kSecAttrProtocol은 InternetProtocol 매개 변수의 rawValue에 바인딩되어 있다.
- 마지막으로 kSecurityAttrAuthenticationType은 InternetAuthenticationType 매개변수의 rawValue에 바인딩된다.
- 다시, Xcode가 제대로 컴파일되는지 확인하기 위해 구축한다.

>참고 : 클래스 kSecClassInternetPassword의 키 체인 항목의 경우 기본 키는 kSecAttrAccunt, kSecAttrSecurityDomain, kSecAttrServer, kSecAtttrProtocol, kSecAtrAutthenticationType, kSecAtrPartrPart의 조합입니다. 
>다시 말해, 이러한 값을 사용하면 키 체인에서 인터넷 암호를 고유하게 식별할 수 있습니다.

- 이제 당신의 모든 노력의 결과를 볼 시간이다.
- 시뮬레이터에서 실행되는 앱을 만들지 않기 때문에 어떻게 검증할 것인가?여기가 유닛 테스트가 구조에 이르는 곳입니다.

## Testing the Behavior

### Creating the Class
- SecureStoreTests.swift 파일을 열고 모든 코드를 제거합니다.
- 다음으로, XCTest 문 아래에 추가하십시오.

```swift
@testable import SecureStore
```

- 이것은 당신의 SecureStore 프레임워크에 정의된 클래스 및 메소드에 대한 단위 테스트 접근을 제공한다.
- 참고: "그런 모듈 없음" 오류가 나타날 수 있다. 
- 자습서 이 절의 끝에 가서 테스트를 수행하면 오류가 사라질 테니 걱정하지 마십시오.
- 다음으로, SecureStoreTests의 상단에 다음 속성을 추가한다.

```swift
var secureStoreWithGenericPwd: SecureStore!
var secureStoreWithInternetPwd: SecureStore!
```

- Next, add a new setUp() method like this:

```swift
override func setUp() {
  super.setUp()
  
  let genericPwdQueryable =
    GenericPasswordQueryable(service: "someService")
  secureStoreWithGenericPwd =
    SecureStore(secureStoreQueryable: genericPwdQueryable)
  
  let internetPwdQueryable =
    InternetPasswordQueryable(server: "someServer",
                              port: 8080,
                              path: "somePath",
                              securityDomain: "someDomain",
                              internetProtocol: .https,
                              internetAuthenticationType: .httpBasic)
  secureStoreWithInternetPwd =
    SecureStore(secureStoreQueryable: internetPwdQueryable)
}
```

- 일반 암호와 인터넷 암호를 모두 테스트하기 때문에 두 개의 다른 구성으로 래퍼의 두 인스턴스를 만듭니다. 
- 이러한 구성이 이전 섹션에서 개발한 구성입니다.
- 잊어버리기 전에, 시험의 찢어지는 단계에서 키 체인의 상태를 지우고 다음 번에 새로 시작할 수 있도록 하십시오. 
- 클래스 끝에 이 방법을 추가합니다.

```swift
override func tearDown() {
  try? secureStoreWithGenericPwd.removeAllValues()
  try? secureStoreWithInternetPwd.removeAllValues()
  
  super.tearDown()
}
```

- 각 테스트를 다른 테스트와 독립적으로 분리하고 실행해야 하기 때문에 키 체인에서 이미 사용 가능한 모든 암호를 삭제할 수 있습니다. 
- 실행 명령은 중요하지 않다.이제 일반 암호에 대한 단위 테스트를 추가할 시간입니다.

### Testing Generic Passwords
- Add the following code below tearDown():

```swift
// 1
func testSaveGenericPassword() {
  do {
    try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
  } catch (let e) {
    XCTFail("Saving generic password failed with \(e.localizedDescription).")
  }
}

// 2
func testReadGenericPassword() {
  do {
    try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
    XCTAssertEqual("pwd_1234", password)
  } catch (let e) {
    XCTFail("Reading generic password failed with \(e.localizedDescription).")
  }
}

// 3
func testUpdateGenericPassword() {
  do {
    try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
    let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
    XCTAssertEqual("pwd_1235", password)
  } catch (let e) {
    XCTFail("Updating generic password failed with \(e.localizedDescription).")
  }
}

// 4
func testRemoveGenericPassword() {
  do {
    try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
    XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
  } catch (let e) {
    XCTFail("Saving generic password failed with \(e.localizedDescription).")
  }
}


// 5
func testRemoveAllGenericPasswords() {
  do {
    try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
    try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
    try secureStoreWithGenericPwd.removeAllValues()
    XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
    XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
  } catch (let e) {
    XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
  }
}
```

- 여기에서 꽤 많은 일이 일어나고 있습니다. 그래서 그것을 무너 뜨립니다.
- testSaveGenericPassword() 방법은 암호를 올바르게 저장할 수 있는지 여부를 확인합니다.
- testReadGenericPassword()는 먼저 암호를 저장한 다음 암호를 검색하여 예상 암호와 동일한지 확인합니다.
- testUpdateGenericPassword()는 동일한 계정에 대해 다른 암호를 저장할 때 확인되며, 최신 암호는 검색 후 예상되는 암호입니다. 
- testRemoveGenericPassword() 테스트를 제거하여 특정 계정에 대한 암호를 제거 할 수 있습니다.
- 마지막으로, testRemoveAllGenericPasswords()는 특정 서비스와 관련된 모든 암호가 Keychain에서 삭제되었는지 확인합니다.
- wrapper가 예외를 던질 수 있기 때문에, 캐치 블록마다 문제가 발생하면 테스트가 실패합니다.