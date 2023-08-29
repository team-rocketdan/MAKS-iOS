//
//  MKFloatingButton.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MKFloatingButton: View {
    let action: () -> ()
    
    /// 버튼이 활성되면 true로 값을 변경합니다. 
    @State var isActive: Bool = false
    var buttonColor: Color {
        isActive ? .mkPointColor : .mkMainColor
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image("message.and.waveform")
                .renderingMode(.template)
                .resizable()
                .frame(width: 16,
                       height: 16)
                .foregroundColor(.white)
                .padding(10)
                .background(buttonColor)
                .cornerRadius(100)
        }

    }
}
