//
//  SearchResultView.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import SwiftUI
import LinkNavigator

struct SearchResultView: View {
    let navigator: LinkNavigatorType
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var marketViewModel: MarketViewModel
    
    @State var searchText: String
    
    @State var isPresentedMarketDetailView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                titleSection
                
                MKSearchBar(text: $searchText)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                
                ScrollView {
                    ForEach(marketViewModel.markets, id: \.id) { market in
                        MarketRowView(market: market) {
//                            isPresentedMarketDetailView = true
                            navigator.next(paths: [RouteMatchPath.marketDetailView.rawValue],
                                           items: ["marketID": "\(market.id)"],
                                           isAnimated: true)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
            }
            
            AISection(navigator: navigator)
                .offset(y: 300)
        }
        .background()
        .onAppear {
            Task {
//                do {
//                    try await marketViewModel.fetchMarkets()
//                } catch {
//                    // Alert
//                    print("\(error.localizedDescription)")
//                }
            }
        }
        .onSubmit {
            //FIXME: HistoryView에 검색결과 반영되어야 함
            navigator.next(paths: [RouteMatchPath.searchResultView.rawValue],
                           items: ["searchText" : searchText],
                           isAnimated: true)
        }
    }
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack {
            Button {
                navigator.remove(paths: [RouteMatchPath.searchResultView.rawValue])
            } label: {
                Image("chevron.left")
                    .renderingMode(.template)
                    .foregroundColor(.mkMainColor)
            }
            
            Spacer()
            
            Text("검색")
                .font(.system(size: 24,
                              weight: .bold))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        
    } // titleSection
}
