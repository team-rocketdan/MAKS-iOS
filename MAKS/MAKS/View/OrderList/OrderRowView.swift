//
//  OrderRowView.swift
//  MAKS
//
//  Created by sole on 2023/09/01.
//

import SwiftUI

struct OrderRowView: View {
    let orderNumber: Int = 101
    let orderDate: Date = .init()
    
    let marketName: String = "크로플러버"
    let orderMenu: String = "플레인 크로플 외 2개"
    let orderTotal: Int = 8600
    
    let marketImage: Image = Image("")
    let orderStatus: String = "조리 중"
    
    
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

    }
    
    //MARK: - orderNumberSection
    
    private var orderNumberSection: some View {
        HStack(spacing: 0) {
            Text("주문번호 \(orderNumber)번")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.mkMainColor)
            
            Spacer()
            
            Text(orderDate.toStringUntilDay())
                .font(.system(size: 14,
                              weight: .medium))
                .foregroundColor(.mkMainColor)
        }
        .padding(.top, 16)
        .padding(.bottom, 12)
        .padding(.horizontal, 20)
        .background(Color.mkGray100)
    } // - orderNumberSection
    
    //MARK: - orderInformationSection
    
    private var orderInformationSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(marketName)
                .font(.system(size: 18,
                              weight: .semibold))
            
            Text(orderMenu)
                .font(.system(size: 14,
                              weight: .light))
            
            Text("\(orderTotal)원")
                .font(.system(size: 14,
                              weight: .medium))
        }
    } // - orderInformationSection
    
    
    //MARK: - marketImageSection
    
    private var marketImageSection: some View {
        Text(orderStatus)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 26)
            .padding(.horizontal, 16)
            .background {
                // FIXME: 실제 매장 이미지로 변경
                marketImage
            }
            .background(Color.mkGray300)
            .cornerRadius(100)
    } // - marketImageSection
}
