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
    /// key - menu.id
    /// value - menu의 개수
    @Published var menusInCart: [Menu : Int] = [:]
    @Published var menuIDs: [String : Menu] = [:]
    
    var totalCountInCart: Int {
        return menusInCart.values.reduce(0,+)
    }
    
    //MARK: - fetchMenusInMarket
    
    /// marketID로 검색하는 query 메서드입니다. 
    func fetchMenusInMarket(marketID: String) async throws {
        let menus = try await apiManager.fetch("\(url)/menus/\(marketID)")
        DispatchQueue.main.async {
            self.menus = menus
        }
    }
    
    func getMenu(menuID: String) async throws -> Menu {
        let menu = try await apiManager.get("\(url)/menu/\(menuID)")
        return menu
    }
    
    func toIDDictionary() -> [String : Int] {
        var result: [String : Int] = [:]
        let menus = menusInCart.keys
        for menu in menus {
            result[menu.id.uuidString, default: 0] += self.menusInCart[menu, default: 1]
        }
        return result
    }
}



