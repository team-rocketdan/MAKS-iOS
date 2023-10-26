//
//  MKFloatingButton.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MKFloatingButton: View {
    /// 버튼이 활성되면 true로 값을 변경합니다.
    @Binding var isActive: Bool
    
    let action: () -> ()
    
    var buttonColor: Color {
        isActive ? .mkPointColor : .mkMainColor
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
    
    //MARK: - label
    
    private var label: some View {
        Image("message.and.waveform")
            .renderingMode(.template)
            .resizable()
            .frame(width: 28,
                   height: 28)
            .foregroundColor(.white)
            .padding(16)
            .background(buttonColor)
            .cornerRadius(100)
    }
}

struct MKFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        MKFloatingButton(isActive: .constant(false)) {}
    }
}
