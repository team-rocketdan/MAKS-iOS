//
//  SearchResultView.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            
            titleSection
            
            MKSearchBar(text: $searchText)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
            
            ScrollView {
                ForEach(0..<10) { index in
                    MarketRowView()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                }
                
            }
            
        }
    }
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image("chevron.left")
                    .renderingMode(.template)
                    .foregroundColor(.mkMainColor)
            }
            
            Spacer()
            
            Text("검색")
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        
    } // titleSection
}
