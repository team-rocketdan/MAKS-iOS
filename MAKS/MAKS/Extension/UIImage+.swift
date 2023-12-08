//
//  UIImage+.swift
//  MAKS
//
//  Created by sole on 2023/10/20.
//

import SwiftUI
import UIKit

extension UIImage {
    func convertToImage() -> Image {
        Image(uiImage: self)
    }
}
