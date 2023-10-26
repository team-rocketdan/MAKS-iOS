//
//  RadioButton.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI

struct RadioButton: View {
    @Binding var isOn: Bool
    let action: () -> (Void)
    
    private var buttonImage: Image {
        isOn ? Image("radio.button.on") : Image("radio.button.off")
    }
    
    private var buttonColor: Color {
        isOn ? .mkMainColor : .mkGray300
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
    
    private var label: some View {
        buttonImage
            .renderingMode(.template)
            .foregroundColor(buttonColor)
    }
}

//MARK: - Previews

#Preview {
    RadioButton(isOn: .constant(true)) {
        
    }
}
