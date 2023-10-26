//
//  MarketRowView.swift
//  MAKS
//
//  Created by sole on 2023/08/31.
//

import SwiftUI

struct MarketRowView: View {
    let marketRate: Double = 4.9
    let marketImageName: String? = nil
    
    let market: Market
    
    var marketRateUntilFirstDecimal: String {
        String(format: "%.1f", marketRate)
    }
    
    let action: () -> (Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
    
    //MARK: - label
    
    private var label: some View {
        HStack(spacing: 12) {
            market.image
                .resizable()
                .frame(width: 93,
                       height: 93)
                .cornerRadius(12)
                .padding(.top, 13)
                .padding(.bottom, 14)
                .padding(.leading, 16)
                
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Text(market.name)
                        .font(.system(size: 18,
                                      weight: .semibold))
                        .foregroundColor(.mkMainColor)
                        
                    
                    HStack(spacing: 8) {
                        Image("star.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.mkPointColor)
                            .frame(width: 14,
                                   height: 14)
                        Text(marketRateUntilFirstDecimal)
                            .font(.system(size: 12,
                                          weight: .light))
                            .foregroundColor(.mkPointColor)
                    }
                }
                .padding(.bottom, 8)
                
                Text(market.description)
                    .font(.system(size: 12,
                                  weight: .light))
                    .foregroundColor(.mkGray500)
                    .padding(.bottom, 26)
                
                Text("매장 혼잡함 | 300m | 도보 6분")
                    .font(.system(size: 12, weight: .medium))
                
                
            }
            Spacer()
                
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .tabBarShadowColor,
                radius: 8,
                x: 0 ,
                y: 1)
    }
}
