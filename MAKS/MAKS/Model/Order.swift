//
//  Order.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation

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
