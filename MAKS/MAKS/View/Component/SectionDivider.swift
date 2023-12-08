//
//  SectionDivider.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI

struct SectionDivider: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.mkGray100)
            .frame(width: UIScreen.screenWidth,
                   height: 10)
    }
}

#Preview {
    SectionDivider()
}
