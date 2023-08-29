//
//  ChevronRightButton.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct ChevronRightButton: View {
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image("chevron.right")
                .renderingMode(.template)
                .foregroundColor(.mkGray500)
        }
    }
}
