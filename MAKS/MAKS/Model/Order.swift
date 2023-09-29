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
    let userID: String
    let menus: [Menu]
    let totalPrice: Int
    let createdAt: Date
    let isTakeOut: Bool
    let status: String
    
    static let defaultModel: Order = .init(id: .init(),
                                           userID: "2345",
                                           menus: [],
                                           totalPrice: 122000,
                                           createdAt: .now,
                                           isTakeOut: false,
                                           status: OrderStatus.done.rawValue)
}
