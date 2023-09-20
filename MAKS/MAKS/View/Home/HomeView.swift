//
//  HomeView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State var text: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleBar()
            
            MKSearchBar(text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            NaverMapView()
            Text("지금 떠오르는 매장")
                .font(.system(size: 20,
                              weight: .bold))
                .padding(.top, 20)
                .padding(.leading, 20)
            
            ScrollView {
                ForEach(0..<5) {_ in
                    MarketRowView()
                        .padding(.top, 16)
                        .padding(.horizontal, 20)
                }
            }
           
            
        }
        .frame(width: UIScreen.screenWidth)
        
    }
}
