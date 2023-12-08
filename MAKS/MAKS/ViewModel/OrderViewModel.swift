//
//  OrderViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
    let url: String = Bundle.main.infoDictionary?["ServerURL"] as? String ?? ""
    let apiManager = APIManager<Order>()
    
    @Published var orderedList: [Order] = []
    @Published var cartOrder: Order? 
    
    //MARK: - fetchOrdersWithUserID
    func fetchOrdersWithUserID(userID: String) async throws {
        let orders = try await apiManager.fetch("\(url)/orders/user/\(userID)")
        DispatchQueue.main.async {
            self.orderedList = orders
        }
    }
    
    //MARK: - registerOrder
    
    func registerOrder(order: Order) async throws -> Data {
        let result = try await apiManager.post("\(url)/order", data: order)
        return result
    }
}
