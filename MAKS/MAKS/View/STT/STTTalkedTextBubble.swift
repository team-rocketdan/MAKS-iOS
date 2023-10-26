//
//  STTTalkedTextBubble.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI

struct STTTalkedTextBubble: View {
    @Binding var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 15,
                          weight: .semibold))
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.mkGray300)
            .cornerRadius(20)
            .opacity(0.5)
    }
}

#Preview {
    STTTalkedTextBubble(text: .constant("안녕하세요"))
}
