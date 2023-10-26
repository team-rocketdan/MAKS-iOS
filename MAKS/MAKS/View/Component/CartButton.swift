//
//  CartButton.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI

struct CartButton: View {
    @Binding var count: Int
    let action: () -> (Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Image("cart")
                .overlay(alignment: .topTrailing) {
                    if count > 0 {
                        Text("\(count)")
                            .font(.system(size: 12,
                                          weight: .semibold))
                            .padding(4)
                            .background(Color.mkPointColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .offset(x: 7, y: -7)
                    }
                }
        }
    }
}

#Preview {
    CartButton(count: .constant(5)) {
        print(1)
    }
}
