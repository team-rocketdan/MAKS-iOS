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
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @State var market: Market = .defaultModel
    
    @State var isPresentedCartView: Bool = false
    @State var isPresentedAlert: Bool = false
    @State var selectedMenu: Menu?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,
                   spacing: 0) {
                titleSection
                
                market.image
                    .resizable()
                    .frame(width: UIScreen.screenWidth)
                    .frame(maxHeight: 285)
                
                menuSection
                
                    .navigationBarBackButtonHidden(true)
                
                if !menuViewModel.menusInCart.isEmpty {
                    MKButton(style: .plain) {
                        navigationViewModel.isPresentedCartView = true
                    } label: {
                        Text("장바구니 보기")
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                }
                
            }
            
            AISection()
                .offset(y: 250)
        }
        .onAppear {
            Task {
                do {
                    self.market = try await marketViewModel.getMarket(marketID: "24780C19-EFDA-4458-ACAA-1A3BF30AD1B9")
                    
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
        .navigationDestination(isPresented: $navigationViewModel.isPresentedCartView) {
            CartView()
        }
        .alert(isPresented: $isPresentedAlert) {
            Alert(title: Text("장바구니에는 한 가게의 메뉴만 담을 수 있습니다. 장바구니를 비우시겠습니까?"),
                  primaryButton: .cancel(),
                  secondaryButton: .default(Text("확인")) {
                removeAllInCartAndAddMenu()
            })
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
            
            CartButton(count: .constant(menuViewModel.totalCountInCart)) {
                isPresentedCartView = true
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
                        menuAddInCart(menu: menu)
                    }
                }
            }
        }
        .frame(width: UIScreen.screenWidth)
    } // - menuSection
    
    //MARK: - menuAddInCart

    func menuAddInCart(menu: Menu) {
        if !menuViewModel.menusInCart.isEmpty {
            if let keyMenu = menuViewModel.menusInCart.keys.first {
                if keyMenu.market.id != menu.market.id {
                    selectedMenu = menu
                    isPresentedAlert = true
                    return
                }
            }
        }
        menuViewModel.menusInCart[menu, default: 0] += 1
    }
    
    //MARK: - removeAllInCartAndAddMenu
    
    func removeAllInCartAndAddMenu() {
        menuViewModel.menusInCart.removeAll()
        guard let menu = selectedMenu
        else { return }
        menuViewModel.menusInCart[menu, default: 0] += 1
    }
}


