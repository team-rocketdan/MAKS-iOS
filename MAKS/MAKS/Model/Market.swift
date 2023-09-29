//
//  Market.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation

enum MarketStatus: String {
    case open = "영업 중"
    case close = "준비 중"
}

struct Market: Codable {
    
    
    let id: UUID
    let name: String
    let coverImage: String?
    let coordinate: [Double]
    let status: String
    let description: String
//    var menus: [Menu]
    
    static let defaultModel: Market = .init(id: .init(),
                                            name: "크로플Love",
                                            coverImage: nil,
                                            coordinate: [],
                                            status: MarketStatus.open.rawValue,
                                            description: "강남의 유명한 크로플, 크로와상 맛집"
                                            )
}
