//
//  TitleBar.swift
//  MAKS
//
//  Created by sole on 2023/08/31.
//

import SwiftUI

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("MAKS")
                .font(.system(size: 28,
                              weight: .black))
                .foregroundColor(.mkMainColor)
            +
            Text(".")
                .font(.system(size: 28,
                              weight: .black))
                .foregroundColor(.mkPointColor)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.screenWidth)
    }
}
