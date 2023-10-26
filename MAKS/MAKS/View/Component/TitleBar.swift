//
//  TitleBar.swift
//  MAKS
//
//  Created by sole on 2023/08/31.
//

import SwiftUI

struct TitleBar: View {
    @Binding var isPresentedCartView: Bool
    
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
            
            Button {
                isPresentedCartView = true
            } label: {
                Image("cart")
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.screenWidth)
        .navigationDestination(isPresented: $isPresentedCartView) {
            CartView()
        }
    }
}

//MARK: - Previews

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar(isPresentedCartView: .constant(false))
            .border(.black)
    }
}
