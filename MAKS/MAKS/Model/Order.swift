//
//  Order.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation
import SwiftyJSON

enum OrderStatus: String {
    case prepare = "준비 중"
    case done = "준비 완료"
}

struct Order: Codable {
    let id: UUID
    let userID: UUID
    let marketID: UUID
    let menus: [String : Int]
    let totalPrice: Int
//    let createdAt: Date
    let isTakeOut: Bool
    let status: String
    let number: Int
    
    static let defaultModel: Order = .init(id: .init(),
                                           userID: UUID(uuidString: "2A13752F-92CC-4A31-9E11-4FAE61FCFC5D") ?? .init(),
                                           marketID: .init(),
                                           menus: [:],
                                           totalPrice: 122000,
//                                           createdAt: .init(),
                                           isTakeOut: false,
                                           status: OrderStatus.done.rawValue,
                                           number: 101)
}

extension Order {
    func toDictionary() throws -> [String : String] {
//        let json = try JSONEncoder().encode(self)
//        let decodedData = try JSONDecoder().decode([String:String].self, from: json)
        var result: [String : String] = [:]
        result["id"] = self.id.uuidString
        result["userID"] = self.userID.uuidString
        result["marketID"] = self.marketID.uuidString
        result["menus"] = "\(self.menus)"
        result["totalPrice"] = "\(self.totalPrice)"
        result["isTakeOut"] = "\(self.isTakeOut)"
        result["status"] = "\(self.status)"
        result["number"] = "\(self.number)"
        
        return result
    }
}

func dictionaryToOrder(dict: [String: String]) throws -> Order {
    let json = try JSONEncoder().encode(dict)
    let decoder = JSONDecoder()
    
    let order = try decodeJSON(data: json, type: Order.self)
    return order
}
