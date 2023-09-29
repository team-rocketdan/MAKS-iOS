//
//  Menu.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation

struct Menu: Codable {
    let id: UUID
    let market: MarketID
    let name: String
    let price: Int
    let description: String
    let imageURL: String?
    
    static let defaultModel: Menu = .init(id: .init(),
                                          market: .init(id: .init()),
                                          name: "감자",
                                          price: 12300,
                                          description: "고소하고 맛있는 강원도 감자",
                                          imageURL: nil)
    
    
    struct MarketID: Codable {
        let id: UUID
    }
}
