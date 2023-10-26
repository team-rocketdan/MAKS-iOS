//
//  SearchHistory.swift
//  MAKS
//
//  Created by sole on 2023/10/16.
//

import Foundation

class SearchHistory: ObservableObject {
    var userDefaultsArray: [String] {
        UserDefaults.standard.array(forKey: "searchHistory") as? [String] ?? []
    }
    let range: ClosedRange<Int> = 0...10
    static let shared = SearchHistory()
    
    @Published var searchHistory: [String] = []
    
    func setUserDefaultsWithSearchHistory() {
        UserDefaults.standard.setValue(searchHistory,
                                       forKey: "searchHistory")
    }
    
    @objc static func userDefaultsDidChange() {
        shared.searchHistory = shared.userDefaultsArray
    }
}
