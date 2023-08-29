//
//  KakaoLoginButton.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct KakaoLoginButton: View {
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 5) {
                Spacer()
                
                Image("kakao.symbol")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.kakaoSymbolColor)
                    .frame(width: 20,
                           height: 20)
                    
                Text("카카오로 로그인")
                    .font(.system(size: 16,
                                  weight: .semibold))
                    .foregroundColor(.kakaoLabelColor)
                
                Spacer()
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(Color.kakaoContainerColor)
            .cornerRadius(12)
        }
    }
    
    private var kakaoButtonLabel: some View {
        HStack(spacing: 5) {
            Image("kakao.symbol")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(.kakaoSymbolColor)
                .frame(width: 20,
                       height: 20)
                
            Text("카카오로 로그인")
                .font(.system(size: 16,
                              weight: .semibold))
                .foregroundColor(.kakaoLabelColor)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 20)
        .background(Color.kakaoContainerColor)
        .cornerRadius(12)
    }
}
