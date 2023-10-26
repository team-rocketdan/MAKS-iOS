//
//  SearchResultView.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var marketViewModel: MarketViewModel
    
    @Binding var searchText: String
    
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
                            isPresentedMarketDetailView = true
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    }
                    
                }
                .navigationBarBackButtonHidden(true)
            }
            
            AISection()
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
        .navigationDestination(isPresented: $isPresentedMarketDetailView) {
            MarketDetailView(market: .defaultModel)
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
                .font(.system(size: 24,
                              weight: .bold))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        
    } // titleSection
}
