//
//  MenuViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import SwiftUI
import Alamofire
import SwiftyJSON

class MenuViewModel: ObservableObject {
    let url: String = Bundle.main.infoDictionary?["ServerURL"] as? String ?? ""
    let apiManager = APIManager<Menu>()
    
    @Published var menus: [Menu] = []
    
    /// marketID로 검색하는 query 메서드
    func fetchMenusInMarket(marketID: String) async throws {
        let menus = try await apiManager.fetch("\(url)/menus/\(marketID)")
        DispatchQueue.main.async {
            self.menus = menus
        }
    }
    
    
    
}



