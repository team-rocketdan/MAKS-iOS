//
//  User.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import SwiftUI

enum LoginCenter: String {
    case kakao = "kakao"
    case apple = "apple"
}

struct User: Codable {
    let id: UUID
    let firebaseID: String
    let name: String
    let email: String
    let loginCenter: String
    var profileImage: String?
    let createdAt: Date
    
    static let defaultModel: User = .init(id: .init(),
                                          firebaseID: "2A13752F-92CC-4A31-9E11-4FAE61FCFC5D",
                                          name: "김이화",
                                          email: "eee@ewhain.net",
                                          loginCenter: LoginCenter.kakao.rawValue,
                                          profileImage: "",
                                          createdAt: .now)
}
