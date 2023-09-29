//
//  MKSearchBar.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MKSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image("search.fill")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20,
                       height: 20)
                .foregroundColor(Color.mkGray500)
            
            TextField("검색어를 입력해주세요",
                      text: $text)
                .font(.system(size: 16,
                              weight: .light))
                .textFieldStyle(.plain)
                
            Spacer()
            
            Button {
                clear()
            } label: {
                Image("close.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20,
                           height: 20)
                    .foregroundColor(Color.mkGray500)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(Color.mkGray100)
        .cornerRadius(10)
    }
    
    //MARK: - label
    
    var label: some View {
        HStack(spacing: 10) {
            Image("search.fill")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20,
                       height: 20)
                .foregroundColor(Color.mkGray500)
            
            Text("주변 매장들을 검색해보세요.")
                .font(.system(size: 14,
                              weight: .light))
                .foregroundColor(.mkGray600)
                
            Spacer()
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(Color.mkGray100)
        .cornerRadius(10)
    }
    
    //MARK: - clear
    
    /// x버튼 탭 시 실행되는 메서드입니다.
    /// text 내 모든 문자열을 삭제합니다.
    func clear() {
        text.removeAll()
    }
}

struct MKSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MKSearchBar(text: .constant(""))
            
            MKSearchBar(text: .constant("")).label
        }
        .padding(20)
    }
}
