# Connectvitiy Guide

- Reachability 샘플 코드는 실제로 연결이 존재하는 지 여부를 탐지할 수 없으며, 연결을 허용할 수 있는 인터페이스만 이용 가능
	- ex> 스타벅스 와이파이: 연결되지 않았어도 연결된 상태로 나타난다.
	- 그래서 검색을 시도하겠지만 결과는 실패로 돌아올 것이다.

## Captive Portal 해결 방법
- iOS는 WISPr 2.0이라는 프로토콜을 채택하고 있다.
	- wi-fi 네트워크에 접속한 것을 감지하기 위해 iOS는 애플이 만들어놓은 많은 endpoint에 접촉한다.
	- ex> https://www.apple.com/library/test/success.html.
	- 이 작은 HTML 페이지를 다운로드할 때 iOS가 성공이라는 단어를 포함하는 것을 발견하면 인터넷 연결이 가능하다는 것을 알 수 있다.

- Connectivity는 오픈소스 프레임워크로 실제로 인터넷 연결이 존재하는지 Captive Portal이 연결을 가로채고 있는지 결정하기 위해 많은 앤드포인트를 접촉한다.


### 사용법
Connectivity가 인터넷에 연결되어 있거나, 연결이 끊겼을 때 또는 두 경우 모두 다음과 같이 인스턴스 하나를 인스턴스화하고 호출할 폐쇄를 할당하기만 하면 된다.

```swift
let connectivity: Connectivity = Connectivity()
let connectivityChanged: (Connectivity) -> Void = { [weak self] connectivity in
     self?.updateConnectionStatus(connectivity.status)
}
connectivity.whenConnected = connectivityChanged
connectivity.whenDisconnected = connectivityChanged
func updateConnectionStatus(_ status: Connectivity.ConnectivityStatus) {
    switch status {
	    case .connectedViaWiFi:
	    case .connectedViaWiFiWithoutInternet:
	    case .connectedViaWWAN:
	    case .connectedViaWWANWithoutInternet:
	    case .notConnected:
    }
        
}
```

Then to start listening for changes in Connectivity call:

```swift
connectivity.startNotifier()
```

Remember to call connectivity.stopNotifier() when you are done.


###One-Off Checks
- 연결 상태를 일회성으로만 확인하고 싶을 때 사용

```swift
let connectivity = Connectivity()
switch connectivity.status {
	case .connectedViaWiFi:
	
	case .connectedViaWiFiWithoutInternet:
	
	case .connectedViaWWAN:
	
	case .connectedViaWWANWithoutInternet:
	
	case .notConnected:
	
}
```

또는 특정 유형의 연결에만 관심이 있는 경우 연결 객체의 다음 속성을 직접 확인할 수 있다.

```swift
var isConnectedViaWWAN: Bool
var isConnectedViaWiFi: Bool
    
var isConnectedViaWWANWithoutInternet: Bool
var isConnectedViaWiFiWithoutInternet: Bool
```


### Connectivity URLs
- startNotifier()로 연결 점검을 시작하기 전에 Connectivity 객체의 connectivityURLs 속성을 통해 연결 여부를 확인하기 위해 접촉할 URL을 설정할 수 있다.

```swift
connectivity.connectivityURLs = [URL(string: “https://www.apple.com/library/test/success.html")!]
```

###Notifications
연결의 변화를 관찰하기 위해 알림을 사용하는 것을 선호하는 경우 기본 NotificationCenter에 관찰자를 추가할 수 있다.
NotificationCenter.default.addObserver(_:selector:name:object:)
Notification.Name.ConnectivityDidChange, 수신된 알림의 개체 속성은 연결 상태를 쿼리하는 데 사용할 수 있는 연결 개체를 포함할 것이다.

###Polling
어떤 경우에는 연결 상태의 변화에 대해 지속적으로 보고를 받아야 할 수 있으므로 폴링을 활성화하기를 원할 수 있다. 이 옵션을 활성화하면 연결은 Relacibility 상태의 변경을 기다리지 않고 10초마다 연결 URL을 폴링한다(이 값은 구성 가능하다). ConnectivityDidChange 알림이 전송되고 연결/연결 해제 시 연결 상태 변경이 발생하는 경우에만 호출된다.
폴링을 활성화하려면:

```swift
connectivity.isPollingEnabled = true
connectivity.startNotifier()
```

### SSL
- 연결 URL에 HTTPS를 사용하는 것이 기본 설정이다. 
- 앱이 App Transport Security를 사용하지 않고 HTTP URL과 HTTPS URL을 사용하려면 isHTTPSOnly to false 또는 set use연결 객체를 다음과 같이 인스턴스화할 때 HTTPS가 false로 된다.
- 먼저 앱의 Info.plist에 NSAllowsArbitraryLoads 플래그를 설정하지 않은 경우 속성이 설정되지 않는다는 점에 유의하십시오.

```swift
let connectivity = Connectivity(shouldUseHTTPS: false)
```

### Threshold
- 이 값은 성공적인 연결 비율을 나타내는 백분율로 지정된다. 즉, 연결 URL 4개가 connectivityURLs 속성에 설정되고 임계값이 75%로 지정되면, 앱이 연결된 것으로 간주되기 위해서는 4개 점검 중 3개가 성공해야 한다.

```swift
connectivity.successThreshold = Connectivity.Percentage(75.0)
```

-------

#Detecting Internet Access on iOS 12+
- iOS 12는 Raccessability를 대체하는 NWPathMonitor를 포함한 네트워크 프레임워크를 도입했다.
- 이런 class는 네트워크 상태의 변화를 감시할 수 있는 수단을 제공한다. (서드파티라이브러리나 애플 샘플코드 필요없이)

## 사용법
- NWPathMonitor 클래스를 사용하려면 Networkframework를 가져온 다음 NWPathMonitor 인스턴스를 생성하기만 하면 된다.

```swift
let monitor = NWPathMonitor()
```

- 특정 네트워크 어댑터의 상태 변경에만 관심이 있는 경우. Wi-Fi, 
	- 그러면 init(requiredInterfaceType:) 초기화기를 사용하여 NWPathMonitor 객체를 인스턴스화하고 NWInterface를 제공하는 것을 감시할 네트워크 어댑터를 지정할 수 있다.
	- interfaceType은 parameter로서 다음과 같다.

```swift
let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
```


- 이 객체에 대한 참조(강력한 속성 사용 등)를 어딘가에 반드시 유지해야 하며, 그렇지 않으면 ARC가 NWPathMonitor 객체를 해제함에 따라 할당한 콜백이 호출되지 않음을 발견할 수 있다.
- 모니터링할 수 있는 인터페이스 유형은 다음과 같다.
	- cellular
	- loopback
	- other (for virtual or undetermined network types)
	- wifi
	- wiredEthernet

- 상태 변경 사항을 notify하려면 네트워크 인터페이스에서 휴대폰이 Wi-Fi 네트워크로 이동할 때마다 호출되는 UpdateHandler 속성에 콜백을 할당해야 한다. 
	- 그런 다음 상태 변화가 발생할 때마다 NWPath 인스턴스가 반환되며, 이 인스턴스는 다음과 같이 연결되어 있는지 여부를 결정하기 위해 쿼리할 수 있다.

```swift
monitor.pathUpdateHandler = { path in
    if path.status == .satisfied {
        print("Connected")
    }
}
```

- 어떤 인터페이스가 상태를 변경하고 콜백을 촉발했는지 알아내야 할 경우 useInterfaceType 방법을 호출할 수 있다.

```swift
let isCellular: Bool = path.usesInterfaceType(.cellular)
```

- NWPathMonitor의 시작 방법은 다음과 같은 작업을 수행하기 위한 개체의 대기열을 제공해야 한다.

```swift
let queue = DispatchQueue.global(qos: .background)
monitor.start(queue: queue)
```

- 주의 변화들에 대한 감시를 마치면, 우리는 그것에 대해 간단히 cancel()을 부른다. 
- 현재 NWPathMonitor에 대해 취소 요청을 하면 다시 시작할 수 없다는 점에 유의하십시오. 
- 대신에, 우리는 새로운 NWPathMonitor 인스턴스를 인스턴스화할 필요가 있다.

```swift
monitor.pathUpdateHandler = { path in
    print(path)
}

Optional(satisfied (Path is satisfied), interface: en0, scoped, ipv4, ipv6, dns)
```

## Captive Portals

- The NWPath.Status enum 은 세가지 케이스를 제공한다
	- satisfied 
	- unsatisfied
	- requiresConnection. 

- 좋은 소식은 NWPathMonitor가 일반적으로 포로로 잡힌 포털을 협상한 후, 즉 웹 뷰가 제시되고 사용자가 로그인한 후에만 경로를 신뢰할 수 있는 것으로 보고한다는 것이다. 

- Charles 프록시 실험을 통해 나는 인터넷 없이 사용을 선택하지 않는 한, NWPathMonitor는 내가 연결을 차단하는 동안 Wi-Fi 네트워크에 처음 연결할 때 NWPath의 상태가 만족스럽다고 정확하게 보고하지 않았다는 것을 발견했다. 
- 인터넷 연결이 복원되었으나 이후에 제거되었다면 이는 감지되지 않았으며 경로 상태는 만족에서 변하지 않았다. 
	- 예를 들어 사용자가 기차나 호텔에서 한 시간 분량의 인터넷 접속료만 내면 이런 일이 발생할 수 있다.

##Connectivity

- 최근 NWPathMonitor에 대한 지원이 iOS 12 이상이 가능한 Connectivity에 추가되었다. 
- 프레임워크 속성이 네트워크로 설정된 경우, 네트워크 어댑터의 상태 변화를 관찰하기 위한 SystemConfigurationframework(Reachability) 대신 새로운 네트워크 프레임워크가 사용될 것이다.

```swift
let connectivity = Connectivity()
connectivity.framework = .network
```
