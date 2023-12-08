//
//  TitleBar.swift
//  MAKS
//
//  Created by sole on 2023/08/31.
//

import SwiftUI
import LinkNavigator

struct TitleBar: View {
    let navigator: LinkNavigatorType
    
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
//                isPresentedCartView = true
                navigator.next(paths: [RouteMatchPath.cartView.rawValue],
                               items: [:],
                               isAnimated: true)
            } label: {
                Image("cart")
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.screenWidth)
//        .navigationDestination(isPresented: $isPresentedCartView) {
//            CartView()
//        }
    }
}
