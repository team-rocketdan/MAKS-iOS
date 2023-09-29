//
//  LoginView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var marketViewModel: MarketViewModel
    
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
                print("login with Apple")
                Task {
                    do {
                        try await marketViewModel.fetchMarkets()
                        userViewModel.isLogin = true
                    } catch {
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
        .frame(width: UIScreen.screenWidth)
        .background(Color.mkMainColor)
    }
    
    //MARK: - sectionOfBrand
    
    private var sectionOfBrand: some View {
        VStack(alignment: .leading,
               spacing: 10) {
            Text("MAKS.")
                .font(.system(size: 38,
                              weight: .black))
                .foregroundColor(.white)
            
            Text("내 손안의 키오스크")
                .font(.system(size: 24,
                              weight: .regular))
                .foregroundColor(.white)
        }
    } // sectionOfBrand
}
