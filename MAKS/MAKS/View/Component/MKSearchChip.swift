//
//  MKSearchChip.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MKSearchChip: View {
    let text: String
    let action: () -> (Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Text(text)
                    .font(.system(size: 16,
                                  weight: .light))
                    .foregroundColor(.mkGray600)
            
                Button {
                    deleteSearchChip()
                } label: {
                    Image("close")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18,
                               height: 18)
                        .foregroundColor(.mkGray600)
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(Color.mkGray100)
            .cornerRadius(12)
        }
    }
    
    //MARK: - deleteSearchChip
    
    func deleteSearchChip() {
        let searchHistoryClass = SearchHistory.shared
        
        guard let index = searchHistoryClass.searchHistory.firstIndex(of: text)
        else { return }
        searchHistoryClass.searchHistory.remove(at: index)
        searchHistoryClass.setUserDefaultsWithSearchHistory()
    }
}

//MARK: - Previews

struct MKSearchChip_Previews: PreviewProvider {
    static var previews: some View {
        MKSearchChip(text: "크로플") {}
    }
}
