//
//  Order.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation

struct Order {
    let id: UUID
    let userID: String
    let menus: [Menu]
    let totalPrice: Int
    let createdAt: Date
    let isTakeOut: Bool
    let status: String
}
