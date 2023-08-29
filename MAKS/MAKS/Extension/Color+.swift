//
//  Color+.swift
//  MAKS
//
//  Created by sole on 2023/08/29.
//

import SwiftUI

extension Color {
    
    static let mkMainColor: Color = .init(hex: 0x1E1F23)
    static let mkSubColor: Color = .init(hex: 0x303236)
    
    static let mkPointColor: Color = .init(hex: 0xFF6924)
    
    /// 숫자값이 커질수록 진한 색입니다.
    static let mkGray700: Color = .init(hex: 0x303236)
    static let mkGray600: Color = .init(hex: 0x4B4D53)
    static let mkGray500: Color = .init(hex: 0x6E7178)
    static let mkGray400: Color = .init(hex: 0x979A9F)
    static let mkGray300: Color = .init(hex: 0xBFC1C5)
    static let mkGray200: Color = .init(hex: 0xE2E3E5)
    static let mkGray100: Color = .init(hex: 0xEBEFF7)
    
    // hex 값으로 색을 초기화합니다.
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
