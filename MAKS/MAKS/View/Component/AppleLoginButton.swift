//
//  AppleLoginButton.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct AppleLoginButton: View {
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            appleLoginButtonLabel
        }

    }
    
    private var appleLoginButtonLabel: some View {
        HStack(spacing: 5) {
            Spacer()
            
            Image("apple.symbol")
                .resizable()
                .frame(width: 24,
                       height: 24)
            
            Text("Apple로 로그인")
                .font(.system(size: 16,
                              weight: .semibold))
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(12)
    }
}
