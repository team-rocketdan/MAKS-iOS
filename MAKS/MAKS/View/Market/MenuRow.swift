//
//  MenuRow.swift
//  MAKS
//
//  Created by sole on 2023/09/05.
//

import SwiftUI

struct MenuRow: View {
    let menuName: String = "플레인 크로플"
    let menuDescription: String = "명불허전 크로플와플의 베스트 메뉴"
    let menuPrice: Int = 4800
    let menuImage: Image? = nil
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 10) {
            HStack(spacing: 20) {
                // FIXME: 실제 상점 이미지로 교체
                Image(systemName: "star")
                    .resizable()
                    .background(Color.mkGray500)
                    .frame(width: 82,
                           height: 82)
                    .cornerRadius(8)
                
                menuInformationSection
            }
            .padding(.trailing, 20)
            
            
            Divider()
                
        }
        .padding(.top, 10)
        .padding(.leading, 20)
        
    }
    
    //MARK: - menuInformationSection
    
    private var menuInformationSection: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text(menuName)
                .font(.system(size: 18,
                              weight: .semibold))
                .padding(.bottom, 6)
            
            Text(menuDescription)
                .font(.system(size: 14,
                              weight: .light))
                .foregroundColor(.mkGray500)
                .padding(.bottom, 20)
            
            Text("\(menuPrice)원")
                .font(.system(size: 16,
                              weight: .medium))
        }
    } // - menuInformationSection
}
