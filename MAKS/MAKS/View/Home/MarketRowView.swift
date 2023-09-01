//
//  MarketRowView.swift
//  MAKS
//
//  Created by sole on 2023/08/31.
//

import SwiftUI

struct MarketRowView: View {
    let marketName: String = "크로플러버"
    let marketRate: Double = 4.9
    let marketDescription: String = "줄 서서 먹는 크로플, 와플 맛집"
    
    var marketRateUntilFirstDecimal: String {
        String(format: "%.1f", marketRate)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image("star")
                .frame(width: 93,
                       height: 93)
                .background(Color.mkGray500)
                .cornerRadius(12)
                .padding(.top, 13)
                .padding(.bottom, 14)
                .padding(.leading, 16)
                
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Text(marketName)
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
                
                Text(marketDescription)
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

extension String {
    
}
