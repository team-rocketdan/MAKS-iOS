//
//  LoginView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//
import SwiftUI
import AuthenticationServices
import AlertToast
import LinkNavigator

struct LoginView: View {
    let navigator: LinkNavigatorType
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var tts: TextToSpeech
    @EnvironmentObject var sttRecognizer: SpeechRecognizer
    @EnvironmentObject var gpt: ChatGPTViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var chatGPTViewModel: ChatGPTViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                sectionOfBrand
                Spacer()
            }
            .padding(.leading, 20)
            
            Spacer()
            
            AppleLoginButton{
                Task {
                    do {
                        alertToastViewModel.isProcessing = true
                        try await marketViewModel.fetchMarkets()
                        alertToastViewModel.isProcessing = false
                        // view navigation to MainRouterView
                        try await userViewModel.login()
                        self.navigator.next(paths: [RouteMatchPath.mainRouterView.rawValue],
                                            items: ["userID": "\(userViewModel.currentUser?.id.uuidString ?? "")"],
                                       isAnimated: true)
                        
                    } catch {
                        alertToastViewModel.isProcessing = false
                        alertToastViewModel.isError = true
                        print("\(error.localizedDescription)")
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            
            KakaoLoginButton {
                print("login with kakao")
                userViewModel.isLogin = true
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
        .frame(width: UIScreen.screenWidth)
        .ignoresSafeArea()
        .background(Color.mkMainColor)
        .disabled(alertToastViewModel.isProcessing)
        .toast(isPresenting: $alertToastViewModel.isProcessing) {
            AlertToast(displayMode: .alert, type: .loading)
        }
        .toast(isPresenting: $alertToastViewModel.isError) {
            AlertToast(displayMode: .alert, type: .error(.red))
        }
    }
    
    //MARK: - sectionOfBrand
    
    private var sectionOfBrand: some View {
        VStack(alignment: .leading,
               spacing: 10) {
            Text("MAKS")
                .font(.system(size: 38,
                              weight: .black))
                .foregroundColor(.white)
            +
            Text(".")
                .font(.system(size: 38,
                              weight: .black))
                .foregroundColor(.mkPointColor)
            
            Text("내 손안의 키오스크")
                .font(.system(size: 24,
                              weight: .regular))
                .foregroundColor(.white)
        }
    } // sectionOfBrand
}
