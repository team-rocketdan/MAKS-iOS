//
//  HomeView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI
import LinkNavigator

struct HomeView: View {
    let navigator: LinkNavigatorType
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    
    @State var text: String = ""
    
//    @State var isPresentedSearchView: Bool = false
//    @State var isPresentedDetailMarketView: Bool = false
//    @State var isPresentedCartView: Bool = false
    @State var selectedMarket: Market?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleBar(navigator: navigator)

            Button {
                // navigate to searchView
                navigationViewModel.isPresentedSearchView = true
                navigator.next(paths: [RouteMatchPath.searchView.rawValue],
                               items: [:],
                               isAnimated: true)
            } label: {
                MKSearchBar(text: $text).label
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            }
            
            NaverMapView()
            
            Text("지금 떠오르는 매장")
                .font(.system(size: 20,
                              weight: .bold))
                .padding(.top, 20)
                .padding(.leading, 20)
            
            ScrollView {
                ForEach(marketViewModel.markets, id: \.id) { market in
                    MarketRowView(market: market) {
                        selectedMarket = market
                        
                        navigator.next(paths: [RouteMatchPath.marketDetailView.rawValue],
                                       items: ["marketID": market.id.uuidString],
                                       isAnimated: true)
//                        navigationViewModel.isPresentedMarketView = true
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(width: UIScreen.screenWidth)
//        .navigationDestination(isPresented: $navigationViewModel.isPresentedSearchView) {
//            SearchView()
//                .environmentObject(navigationViewModel)
//                .environmentObject(marketViewModel)
//                .environmentObject(menuViewModel)
//        }
//        .navigationDestination(isPresented: $navigationViewModel.isPresentedMarketView) {
//            MarketDetailView(market: selectedMarket ?? .defaultModel)
//                .environmentObject(navigationViewModel)
//                .environmentObject(marketViewModel)
//                .environmentObject(menuViewModel)
//        }
    }
}
