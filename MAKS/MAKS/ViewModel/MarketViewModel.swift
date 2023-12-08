//
//  MarketViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//
import UIKit
import SwiftUI

class MarketViewModel: ObservableObject {
    let url: String = Bundle.main.infoDictionary?["ServerURL"] as? String ?? ""
    let apiManager = APIManager<Market>()
    @Published var markets: [Market] = []
    @Published var searchedMarkets: [Market] = []
    
    //MARK: - fetchMarkets
    
    /// 주변 가게들을 모두 fetch 해오는 메서드입니다.
    func fetchMarkets() async throws {
        let markets = try await apiManager.fetch("\(url)/markets")
        DispatchQueue.main.async {
            self.markets = markets
        }
    }
    
    //MARK: - searchMarkets
    
    /// 검색한 market을 모두 검색해서 fetch하는 메서드입니다.
    func searchMarkets(_ searchText: String) async throws {
        let markets = try await apiManager.fetch("\(url)/search/\(searchText)")
        DispatchQueue.main.async {
            self.searchedMarkets = markets
        }
    }
    
    
    //MARK: - getMarket
    
    func getMarket(marketID: String) async throws -> Market {
        let market = try await apiManager.get("\(url)/market/\(marketID)")
        return market
    }
}


