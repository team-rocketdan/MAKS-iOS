//
//  STTChatView.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI

struct STTChatView: View {
    @Binding var text: String
    var body: some View {
        VStack {
            Text(text)
        }
        .background(Color.clear)
        .frame(height: UIScreen.screenHeight)
    }
}
