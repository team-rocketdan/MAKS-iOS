//
//  String+.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI

extension String {
    func base64StringToImage() -> Image? {
        guard let data = Data(base64Encoded: self)
        else { return nil }
        guard let uiImage = UIImage(data: data)
        else { return nil }
        let image = Image(uiImage: uiImage)
        return image
    }
}
