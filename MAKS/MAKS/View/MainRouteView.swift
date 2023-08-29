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
                Text("Home View")
            case .search:
                Text("Search View")
            case .order:
                Text("Order List View")
            case .myPage:
                MyPageView()
            }
            
            MKTabBar(selectedIndex: $selectedIndex)
        }
    }
}
