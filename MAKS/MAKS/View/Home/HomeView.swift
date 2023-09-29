//
//  HomeView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    
    @State var text: String = ""
    
    @State var isPresentedSearchView: Bool = false
    @State var isPresentedDetailMarketView: Bool = false
    @State var selectedMarket: Market?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TitleBar()

            Button {
                // navigate to searchView
                isPresentedSearchView = true
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
                        Task {
                            do {
                                try await menuViewModel.fetchMenusInMarket(marketID: market.id.uuidString)
                            } catch {
                                print("\(error.localizedDescription)")
                            }
                        }
                        
                        isPresentedDetailMarketView = true
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 20)
                }
            }
        }
        .frame(width: UIScreen.screenWidth)
        .navigationDestination(isPresented: $isPresentedSearchView) {
            SearchView()
                .environmentObject(marketViewModel)
                .environmentObject(menuViewModel)
        }
        .navigationDestination(isPresented: $isPresentedDetailMarketView) {
            MarketDetailView(market: selectedMarket ?? .defaultModel)
                .environmentObject(marketViewModel)
                .environmentObject(menuViewModel)
        }
    }
}
