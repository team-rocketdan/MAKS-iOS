//
//  CartView.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI
import LinkNavigator

struct CartView: View {
    let navigator: LinkNavigatorType
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @State var market: Market = .defaultModel
    @State var requestMessage: String = ""
    @State var isPresentedPaymentView: Bool = false
    @State var order: Order?
    
    var marketID: String {
        guard let menu = menuViewModel.menusInCart.keys.first
        else { return "" }
        return menu.market.id.uuidString
    }
    
    var totalPayment: Int {
        var result: Int = 0
        for menu in menuKeys {
            let countOfMenu = menuViewModel.menusInCart[menu, default: 0]
            result += menu.price * countOfMenu
        }
        return result
    }
    
    var menuKeys: [Menu] {
        Array(menuViewModel.menusInCart.keys)
    }
    
    var isPresentedEmptyView: Bool {
        menuKeys.isEmpty
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,
                   spacing: 0) {
                
                titleSection
                    .padding(.horizontal, 20)
                
                if !isPresentedEmptyView {
                    ScrollView {
                        content
                    }
                    .navigationBarBackButtonHidden(true)
                } else {
                    emptyView
                        .navigationBarBackButtonHidden(true)
                }
                
            }
            
            AISection(navigator: navigator)
                .offset(y: 250)
        }
        .onAppear {
            /// 장바구니가 비어있는 경우 실행을 중단합니다.
            guard !marketID.isEmpty
            else { return }
            
            Task {
                do {
                    market = try await marketViewModel.getMarket(marketID: marketID)
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: - content
    
    private var content: some View {
        VStack(alignment: .leading) {
            marketTitleSection
                .padding(.horizontal, 20)
            
            Divider()
            
            ForEach(menuKeys, id: \.self) { key in
                CartRowView(menu: key, count: menuViewModel.menusInCart[key, default: 0]) {
                    // delete menu in cart
                    deleteMenuInCart(menu: key)
                }
                .padding(.horizontal, 20)
                
                if key != menuKeys[menuKeys.count - 1] {
                    Divider()
                        .padding(.leading, 20)
                }
            }
            
            SectionDivider()
            
            totalOrderPaymentSection
                .padding(.horizontal, 20)
            Divider()
            
            expectedPaymentSection
                .padding(.horizontal, 20)
            SectionDivider()
            
            requestMessageSection
                .padding(.horizontal, 20)
            
            Spacer()
            
            MKButton(style: .plain) {
                // order menus
                let order = Order(id: .init(),
                                  //FIXME: currentUser로 수정
                                  userID: Order.defaultModel.userID,
                                  marketID: market.id,
                                  menus: menuViewModel.toIDDictionary(),
                                  totalPrice: totalPayment,
//                                  createdAt: .init(),
                                  isTakeOut: false,
                                  status: "확인 중",
                                  number: 101)
                self.order = order
                orderViewModel.cartOrder = order
                navigator.next(paths: [RouteMatchPath.payView.rawValue],
                               items: [:],
                               isAnimated: true)

            } label: {
                Text("주문하기")
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
        }
    }
    
    //MARK: - emptyView
    
    private var emptyView: some View {
        VStack {
            Image(systemName: "trash.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.mkGray300)
        
                Text("메뉴를 담아주세요!")
                    .font(.system(size: 24,
                                  weight: .semibold))
                    .foregroundColor(.mkGray300)
            Spacer()
        }
        .frame(width: UIScreen.screenWidth)
        .padding(.top, 100)
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack(spacing: 110) {
            Button {
                dismiss()
            } label: {
                Image("chevron.left")
            }
            
            Text("장바구니")
                .font(.system(size: 24,
                              weight: .bold))
            
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
    //MARK: - requestMessageSection
    
    private var requestMessageSection: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text("요청사항")
                .font(.system(size: 20,
                              weight: .bold))
                .padding(.vertical, 10)
            
            
            RequestTextField(text: $requestMessage)
                .padding(.bottom, 20)
        }
               
    }
    
    //MARK: - marketTitleSection
    
    private var marketTitleSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(market.name)
                .font(.system(size: 20,
                              weight: .bold))
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
    //MARK: - totalOrderPayment
    
    private var totalOrderPaymentSection: some View {
        HStack(spacing: 0) {
            Text("총 주문금액")
            Spacer()
            Text("\(totalPayment)원")
        }
        .font(.system(size: 18,
                      weight: .medium))
        .padding(.vertical, 20)
    }
    
    //MARK: - expectedPaymentSection
    
    private var expectedPaymentSection: some View {
        HStack {
            Text("결제예정금액")
            
            Spacer()
            
            Text("\(totalPayment)원")
        }
        .font(.system(size: 18,
                      weight: .bold))
        .padding(.vertical, 20)
    }
    
    func deleteMenuInCart(menu: Menu) {
        menuViewModel.menusInCart.removeValue(forKey: menu)
    }
}
