//
//  RequestTextField.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI

struct RequestTextField: View {
    @Binding var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.mkGray100)
            .overlay(alignment: .topLeading) {
                TextField("사장님께 요청할 사항을 작성해주세요.",
                          text: $text,
                          axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .padding(20)
            }
            .frame(height: 145)
    }
}

#Preview {
    RequestTextField(text: .constant("감자"))
}
