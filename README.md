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
- Pods
4. 다운로드 받은 파일들을 MAKS 폴더로 옮겨줍니다.


## 테스트 방법 

- Apple의 보안 정책 상 .ipa 파일을 통한 설치는 불가능합니다. 아래 제공된 링크를 통해 TestFlight를 사용하여 테스트를 진행하실 수 있습니다.
- **iOS 16.0+에서만** 설치 및 실행이 가능합니다. 
1. App Store에서 TestFlight를 다운로드 받습니다.
2. 제공된 링크에 접속하여 MAKS.앱을 다운로드합니다. 

 <details>
    <summary>AlertToast</summary>
    <div markdown="1">
        MIT License
    </div>
</details>

## 사용 기술 
- SwiftUI(mainly)
- UIKit(partially)
- Apple Speech (Speech-To-Text)
- AVFoundation (Text-To-Speech)
  
## 오픈소스 라이선스 

### UI
- AlertToast
  
### View Navigation
- LinkNavigator
  
### RESTful API
- Alamofire

### Login
- FirebaseSDK
- KakaoSDK

### Map
- NaverMap

### Speech-To-Text(STT)
- Apple Speech 



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

## 트러블 슈팅
- <a href="www.naver.com">LinkNavigator를 도입하며</a>
- <a href="www.naver.com">시리처럼 STT 구성해보기</a>
  
