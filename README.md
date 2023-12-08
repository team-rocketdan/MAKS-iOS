# MAKS_iOS

## 지원 정보 
- iOS 16.0+<br>
- 다크모드, 가로모드 미지원

## 소스 코드 빌드 방법
- **MacOS 환경에서만** 빌드가 가능합니다. (Windows에서는 빌드가 불가능하니 참고하여 주세요.)<br>
1. 소스 코드를 로컬 컴퓨터에 다운로드 받습니다. 
2. App Store에서 Xcode를 다운로드 받습니다.
3. 아래 나열된 파일들을 Google Drive에서 다운로드 받습니다. (보안 상 민감한 정보가 포함되어 있어 커밋내역에 포함되지 않았습니다. 소스코드를 통한 빌드를 원하실 경우 hmheo128@gmail.com로 연락을 주시면 파일을 제공하여 드립니다.)
- GoogleServiceInfo.plist
- Info.plist
4. 다운로드 받은 파일들을  MAKS_iOS/MAKS/MAKS 폴더로 옮겨줍니다.
5. MAKS_iOS/MAKS/ 폴더로 이동합니다. MAKS.xcodeproj 파일이 있는 위치까지 이동하시면 됩니다.<br>
이제 NaverMap의 Pods 파일을 다운로드 받아야 합니다. 
6. CocoaPods가 없으면 CocoaPods를 먼저 install 합니다
  ```
brew install cocoapods
  ```
6. 현재 위치에서 터미널을 열어줍니다. 아래 소스코드를 통해 Podfile을 생성해줍니다. 
  ```
pod init
  ```
7. 폴더에 Podfile이 생겼을 것입니다. 기존에 작성되어 있는 내용을 모두 지우고 Podfile에 아래 내용을 작성하고 저장해주세요.
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
target 'MAKS' do
  pod 'NMapsMap'
end
```
8. 터미널에서 아래 코드를 작성해 NaverMap을 다운로드 합니다.
```
pod install
```
9. Pods 설치가 완료되었으면 **MAKS.xcworkspace**를 더블 클릭합니다. (주의. MAKS.xcodeproj를 통해 빌드를 시도하면 에러가 발생합니다. 반드시 xworkspace에서 빌드를 진행해주세요.)
10. **Run** 버튼을 눌러 실행시키면 프로젝트가 빌드됩니다. 


## 테스트 방법 

- Apple의 보안 정책 상 .ipa 파일을 통한 설치는 불가능합니다. 아래 제공된 링크를 통해 **TestFlight를 사용하여 테스트를 진행하실 수 있습니다.**
- **iOS 16.0+에서만** 설치 및 실행이 가능합니다.
TestFlight 베타테스터 링크: https://testflight.apple.com/join/37zPS6m9
1. App Store에서 TestFlight를 다운로드 받습니다.
2. 제공된 링크에 접속하여 MAKS.앱을 다운로드합니다.
3. 테스트를 진행하시면 됩니다.
참고로 테스트를 위해 로그인 과정을 생략할 수 있도록 설정했습니다. 테스트 계정이 별도로 제공되지 않는 이유입니다. 
**Apple로 로그인하기**를 탭하시면 로딩 후 정상적으로 테스트를 진행하실 수 있습니다. (카카오로 로그인하기의 경우는 서버 데이터가 정상적으로 들어오지 않을 수 있습니다.)

## 사용 기술 
- SwiftUI(mainly)
- UIKit(partially)
- Apple Speech (Speech-To-Text)
- AVFoundation (Text-To-Speech)
  
## 오픈소스 라이선스 

### UI
 <details>
    <summary>AlertToast (MIT License) </summary>
    <div markdown="1">
        https://github.com/elai950/AlertToast
    </div>
</details>
  
### RESTful API
 <details>
    <summary>Alamofire (MIT License) </summary>
    <div markdown="1">
        https://github.com/Alamofire/Alamofire
    </div>
</details>
  
### View Navigation
 <details>
    <summary>LinkNavigator (MIT License) </summary>
    <div markdown="1">
    https://github.com/interactord/LinkNavigator
    </div>
</details>

### Login
 <details>
    <summary>Firebase iOS SDK (Apache-2.0) </summary>
    <div markdown="1">
    https://github.com/firebase/firebase-ios-sdk
    </div>
</details>

- KakaoSDK
 <details>
    <summary>Kakao iOS SDK (Apache-2.0) </summary>
    <div markdown="1">
     https://github.com/kakao/kakao-ios-sdk
    </div>
</details>

### Map
 <details>
    <summary>NaverMap (Apache-2.0) </summary>
    <div markdown="1">
     https://github.com/navermaps/ios-map-sdk
    </div>
</details>


---

## 아키텍처 
- MVVM Pattern<br>
![image](https://github.com/team-rocketdan/MAKS-iOS/assets/97100404/7ea2be2c-f69a-490f-919a-2714a0566fb1)

(출처: https://ko.wikipedia.org/wiki/%EB%AA%A8%EB%8D%B8-%EB%B7%B0-%EB%B7%B0%EB%AA%A8%EB%8D%B8)


## 폴더 구조 
```sh
MAKS
├── Assets.xcassets
├── Constant
├── Extension
│   ├── Color+.swift
│   ├── Date+.swift
│   ├── Image+.swift
│   ├── String+.swift
│   ├── UIImage+.swift
│   └── UIScreen+.swift
├── Model
│   ├── GPTRequest.swift
│   ├── GPTResponse.swift
│   ├── Market.swift
│   ├── Menu.swift
│   ├── Message.swift
│   ├── Order.swift
│   └── User.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── UIConfig
├── View
│   ├── MAKSApp.swift
│   ├── MainRouteView.swift
│   ├── AISection.swift
│   ├── Component
│   │   ├── AppleLoginButton.swift
│   │   ├── CartButton.swift
│   │   ├── ChevronRightButton.swift
│   │   ├── KakaoLoginButton.swift
│   │   ├── MKButton.swift
│   │   ├── MKFloatingButton.swift
│   │   ├── MKSearchBar.swift
│   │   ├── MKSearchChip.swift
│   │   ├── MKSendButton.swift
│   │   ├── MKStepper.swift
│   │   ├── MKTabBar.swift
│   │   ├── RadioButton.swift
│   │   ├── RequestTextField.swift
│   │   ├── SectionDivider.swift
│   │   └── TitleBar.swift
│   ├── Home
│   │   ├── Cart
│   │   │   ├── CartRowView.swift
│   │   │   ├── CartView.swift
│   │   │   ├── OrderCompleteView.swift
│   │   │   └── PaymentView.swift
│   │   ├── HomeView.swift
│   │   └── NaverMapView.swift
│   ├── Login
│   │   └── LoginView.swift
│   ├── Market
│   │   ├── MarketDetailView.swift
│   │   ├── MarketRowView.swift
│   │   └── MenuRow.swift
│   ├── MyPage
│   │   └── MyPageView.swift
│   ├── Navigator
│   │   ├── AppDependency.swift
│   │   └── AppRouterGroup.swift
│   ├── OrderList
│   │   ├── OrderListView.swift
│   │   └── OrderRowView.swift
│   ├── RouteBuilder
│   │   ├── CartRouteBuilder.swift
│   │   ├── LoginRouteBuilder.swift
│   │   ├── MainRouteBuilder.swift
│   │   ├── MarketDetailRouteBuilder.swift
│   │   ├── OrderCompleteRouteBuilder.swift
│   │   ├── PayRouteBuilder.swift
│   │   ├── RouteMatchPath.swift
│   │   ├── SearchResultRouteBuilder.swift
│   │   └── SearchRouteBuilder.swift
│   ├── STT
│   │   ├── STTChatBubble.swift
│   │   ├── STTTalkedTextBubble.swift
│   │   ├── STTTestView.swift
│   │   └── SpeechRecognizer.swift
│   ├── Search
│   │   ├── SearchHistory.swift
│   │   ├── SearchResultView.swift
│   │   └── SearchView.swift
│   └── TTS
│       └── TextToSpeech.swift
└── ViewModel
    ├── APIManager.swift
    ├── AlertToastViewModel.swift
    ├── ChatGPTViewModel.swift
    ├── FirebaseManager.swift
    ├── MVIContainer
    │   └── MVIContainer.swift
    ├── MarketViewModel.swift
    ├── MenuViewModel.swift
    ├── NavigationViewModel.swift
    ├── OrderViewModel.swift
    ├── UserViewModel.swift
    └── ViewModelProtocol.swift

```
  
