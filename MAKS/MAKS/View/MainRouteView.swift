//
//  MainRouteView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MainRouteView: View {
    @State var selectedIndex: Int = 0

    @State var isPresentedSearchView: Bool = false
    
    var focusedTab: TabBarIndex {
        TabBarIndex(rawValue: selectedIndex) ?? .home
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                    switch focusedTab {
                    case .home, .search:
                        HomeView()
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
            .onChange(of: selectedIndex) { newValue in
                if newValue == TabBarIndex.search.rawValue {
                    isPresentedSearchView = true
                    selectedIndex = TabBarIndex.home.rawValue
                }
            }
            .navigationDestination(isPresented: $isPresentedSearchView) {
                SearchView()
                    .padding(.bottom, 75)
        }
        }
        
    }
}
