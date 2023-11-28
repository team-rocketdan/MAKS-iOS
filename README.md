# MAKS_iOS

## 지원 정보 
iOS 16.0+
다크모드, 가로모드 미지원

## 설치 방법 
1. .ipa 파일을 통한 설치
2. github를 통한 설치
- GoogleServiceInfo.plist
- Info.plist
- Pods(Naver Map)<br>
위의 파일들은 보안을 위해 커밋 내역에 포함되지 않았습니다. 깃허브 소스코드를 통한 빌드를 원하실 경우 따로 연락을 주시어 요청하여 주시면 파일을 제공해드립니다.
더불어 Naver Map을 사용하실 경우 CocoaPods를 통해 Naver Map Pods 파일을 다운로드 받으셔야 합니다.

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


## 사용 프레임워크 & 라이브러리 
### UI
- SwiftUI(mainly)
- UIKit(partially)
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

## 트러블 슈팅
- <a href="www.naver.com">LinkNavigator를 도입하며</a>
- <a href="www.naver.com">시리처럼 STT 구성해보기</a>
  
