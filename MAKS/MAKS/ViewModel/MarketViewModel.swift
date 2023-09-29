//
//  MarketViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import SwiftUI

class MarketViewModel: ObservableObject {
    let url: String = Bundle.main.infoDictionary?["ServerURL"] as? String ?? ""
    let apiManager = APIManager<Market>()
    @Published var markets: [Market] = []
    
    /// 주변 가게들을 모두 fetch 해오는 메서드입니다.
    func fetchMarkets() async throws {
        let markets = try await apiManager.fetch("\(url)/markets")
        DispatchQueue.main.async {
            self.markets = markets
        }
    }
    
    /// 검색한 market을 모두 검색해서 fetch하는 메서드입니다.
    func searchMarkets() {
        
    }
}


