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
                    .padding(.bottom, 75)
            case .search:
                SearchView()
                    .padding(.bottom, 75)
            case .order:
                OrderListView()
                    .padding(.bottom, 75)
            case .myPage:
                MyPageView()
                    .padding(.bottom, 75)
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
                    .ignoresSafeArea()
                    .frame(maxHeight: 72)
            }
        }
    }
}
