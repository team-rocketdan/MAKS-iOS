//
//  OrderRowView.swift
//  MAKS
//
//  Created by sole on 2023/09/01.
//

import SwiftUI

struct OrderRowView: View {
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var marketViewModel: MarketViewModel
    
    @State var market: Market = .defaultModel
    let order: Order
    
    var menuLabel: String {
        let keys = Array(menuViewModel.menuIDs.keys)
        guard keys.count > 0
        else { return "" }
       
        var result = "\(menuViewModel.menuIDs[keys[0], default: .defaultModel].name) "
        if keys.count > 1 {
            result += "외 \(keys.count - 1)개"
        }
        return result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            orderNumberSection
            
            HStack(spacing: 0) {
                
                orderInformationSection
                
                Spacer()
                
                marketImageSection
    
            }
            .padding(.top, 15)
            .padding(.bottom, 21)
            .padding(.horizontal, 20)
                        .background(Color.white)
        }
        .cornerRadius(16)
        .shadow(color: .tabBarShadowColor,
                radius: 4,
                x: 0,
                y: 1)
        .onAppear {
            fetchMenusInOrder()
            getMarket()
        }

    }
    
    //MARK: - orderNumberSection
    
    private var orderNumberSection: some View {
        HStack(spacing: 0) {
            Text("주문번호 \(order.number)번")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.mkMainColor)
            
            Spacer()
            
            Text(Date().toStringUntilDay())
                            .font(.system(size: 14,
                                          weight: .medium))
                            .foregroundColor(.mkMainColor)
            
//            Text(order.createdAt.toStringUntilDay())
//                .font(.system(size: 14,
//                              weight: .medium))
//                .foregroundColor(.mkMainColor)
        }
        .padding(.top, 16)
        .padding(.bottom, 12)
        .padding(.horizontal, 20)
        .background(Color.mkGray100)
    } // - orderNumberSection
    
    //MARK: - orderInformationSection
    
    private var orderInformationSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(market.name)
                .font(.system(size: 18,
                              weight: .semibold))
            
            Text(menuLabel)
                .font(.system(size: 14,
                              weight: .light))
            
            Text("\(order.totalPrice)원")
                .font(.system(size: 14,
                              weight: .medium))
        }
    } // - orderInformationSection
    
    
    //MARK: - marketImageSection
    
    private var marketImageSection: some View {
        Text(order.status)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 26)
            .padding(.horizontal, 16)
            .background {
                // FIXME: 실제 매장 이미지로 변경
                market.image
                    .resizable()
                    .frame(width: 69, height: 69)
            }
            .background(Color.mkGray200)
            .clipShape(Circle())
    } // - marketImageSection
    
    func fetchMenusInOrder() {
        let menuIDs = Array(order.menus.keys)
        
        Task {
            do {
                for menuID in menuIDs {
                    menuViewModel.menuIDs[menuID] = try await menuViewModel.getMenu(menuID: menuID)
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func getMarket() {
        Task {
            do {
                self.market = try await marketViewModel.getMarket(marketID: order.marketID.uuidString)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
