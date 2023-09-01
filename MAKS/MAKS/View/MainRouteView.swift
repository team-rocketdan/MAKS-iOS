//
//  MainRouteView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MainRouteView: View {
    @State var selectedIndex: Int = 0
    
    var focusedTab: TabBarIndex {
        TabBarIndex(rawValue: selectedIndex) ?? .home
    }
    
    var body: some View {
        ZStack {
            switch focusedTab {
            case .home:
                HomeView()
                    .padding(.bottom, 80)
            case .search:
                Text("Search View")
            case .order:
                Text("Order List View")
            case .myPage:
                MyPageView()
                    .padding(.bottom, 90)
            }
            
            
            VStack(spacing: 0) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    MKFloatingButton {
                        print("floating Button")
                    }
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20)
                
                MKTabBar(selectedIndex: $selectedIndex)
            }
        }
    }
}
