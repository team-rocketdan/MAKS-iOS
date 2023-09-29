//
//  MenuRow.swift
//  MAKS
//
//  Created by sole on 2023/09/05.
//

import SwiftUI

struct MenuRow: View {
    let menu: Menu
    
    var menuImage: Image {
        guard let image = menu.imageURL
        else { return Image.imagePlaceHolder }
        
        return Image(image)
    }
    
    let action: () -> (Void)
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 10) {
            
            Button {
                action()
            } label: {
                HStack(spacing: 20) {
                    // FIXME: 실제 상점 이미지로 교체
                    menuImage
                        .resizable()
                        .frame(width: 82,
                               height: 82)
                        .cornerRadius(8)
                    
                    menuInformationSection
                }
                .padding(.trailing, 20)
            }
            
            Divider()
                
        }
        .padding(.top, 10)
        .padding(.leading, 20)
        
    }
    
    //MARK: - menuInformationSection
    
    private var menuInformationSection: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            Text(menu.name)
                .font(.system(size: 18,
                              weight: .semibold))
                .padding(.bottom, 6)
            
            Text(menu.description)
                .font(.system(size: 14,
                              weight: .light))
                .foregroundColor(.mkGray500)
                .padding(.bottom, 20)
            
            Text("\(menu.price)원")
                .font(.system(size: 16,
                              weight: .medium))
        }
    } // - menuInformationSection
}
