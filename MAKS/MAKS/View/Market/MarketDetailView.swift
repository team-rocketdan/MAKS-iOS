//
//  MarketDetailView.swift
//  MAKS
//
//  Created by sole on 2023/09/05.
//

import SwiftUI

struct MarketDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    
    let market: Market
    
    @State var isPresentedCartView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            titleSection
            
            Image.imagePlaceHolder
                .resizable()
                .frame(width: UIScreen.screenWidth)
                .frame(maxHeight: 285)
            
            menuSection
            
                .navigationBarBackButtonHidden(true)
        }
               .navigationDestination(isPresented: $isPresentedCartView) {
                   Text("cart view")
               }
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack(spacing: 20) {
            Button {
                dismiss()
            } label: {
                Image("chevron.left")
            }
            
            Text(market.name)
                .font(.system(size: 24,
                              weight: .bold))
            
            Spacer()
            
            Button {
                print("navigate to 장바구니")
            } label: {
                Image("cart")
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    } // - titleSection
    
    //MARK: - menuSection
    
    private var menuSection: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text("대표메뉴")
                .font(.system(size: 20,
                              weight: .bold))
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding(.leading, 20)
            
            Divider()
            
            ScrollView {
                ForEach(menuViewModel.menus, id: \.id) { menu in
                    MenuRow(menu: menu) {
                        // navigate to menu detail view OR add menu to cart
                    }
                }
            }
            
            
            MKButton(style: .plain) {
                print("1")
            } label: {
                Text("장바구니 보기")
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            
        }
               .frame(width: UIScreen.screenWidth)
    } // - menuSection
    
}


