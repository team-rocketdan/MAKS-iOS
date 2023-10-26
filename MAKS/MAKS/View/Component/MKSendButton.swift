//
//  MKSendButton.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI

struct MKSendButton: View {
    @Binding var isActive: Bool
    let action: () -> (Void)
    
    private var buttonColor: Color {
        isActive ? .mkPointColor : .mkMainColor
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
        .disabled(!isActive)
    }
    
    //MARK: - label
    
    private var label: some View {
        Image(systemName: "arrow.up")
            .font(.callout)
            .foregroundColor(.white)
            .padding(10)
            .background(buttonColor)
            .clipShape(Circle())
    }
}

#Preview {
    MKSendButton(isActive: .constant(false)) {
        print(1)
    }
}
