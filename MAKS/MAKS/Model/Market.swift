//
//  Market.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation
import SwiftUI

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
    
    var image: Image {
        guard let imageData = coverImage
        else {
            return .imagePlaceHolder
        }
        return imageData.base64StringToImage() ?? .imagePlaceHolder
    }
    
    var latitude: Double {
        guard coordinate.count > 2
        else { return 0 }
        return coordinate[0]
    }
    
    var longitude: Double {
        guard coordinate.count > 2
        else { return 0 }
        return coordinate[1]
    }
    
    static let defaultModel: Market = .init(id: UUID(uuidString: "24780C19-EFDA-4458-ACAA-1A3BF30AD1B9") ?? .init(),
                                            name: "크로플Love",
                                            coverImage: nil,
                                            coordinate: [],
                                            status: MarketStatus.open.rawValue,
                                            description: "강남의 유명한 크로플, 크로와상 맛집"
                                            )
}
