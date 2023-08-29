//
//  MKSearchChip.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MKSearchChip: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(text)
                .font(.system(size: 16,
                              weight: .light))
                .foregroundColor(.mkGray600)
        
            Button {
                deleteSearchChip()
            } label: {
                Image("close")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 18,
                           height: 18)
                    .foregroundColor(.mkGray600)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 10)
        .background(Color.mkGray100)
        .cornerRadius(12)
    }
    
    func deleteSearchChip() {
        // have to fill
    }
}
