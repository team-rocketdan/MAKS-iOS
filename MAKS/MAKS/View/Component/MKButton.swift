//
//  MKButton.swift
//  MAKS
//
//  Created by sole on 2023/08/29.
//

import SwiftUI

enum MKButtonStyle {
    case plain
}

struct MKButton<Label: View>: View {
    
    let style: MKButtonStyle
    let action: () -> (Void)
    let label: Label
    
    init(style: MKButtonStyle,
         action: @escaping () -> Void,
         label: Label) {
        self.style = style
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
                .mkButtonViewModifier(style: style)
        }

    }
    
}

struct MKButtonViewModifier: ViewModifier {
    let style: MKButtonStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .plain:
            return content
                .font(.system(size: 20,
                              weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 18)
                .padding(.horizontal, 20)
                .background(Color.mkMainColor)
                .cornerRadius(10)
        }
    }
}

extension View {
    func mkButtonViewModifier(style: MKButtonStyle) -> some View {
        self.modifier(MKButtonViewModifier(style: style))
    }
}
