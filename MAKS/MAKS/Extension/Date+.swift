//
//  Date+.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import Foundation

extension Date {
    //// yyyy.MM.dd. 형태의 문자열로 Date를 반환하는 메서드입니다.
    func toStringUntilDay() -> String {
        let formatter = DateFormatter()
        let locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd."
        
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
