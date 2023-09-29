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
            label
        }
    }
    
    //MARK: - label
    
    var label: some View {
        Image("chevron.right")
            .renderingMode(.template)
            .foregroundColor(.mkGray500)
    }
}

//MARK: - Previews

struct ChevronRightButton_Previews: PreviewProvider {
    static var previews: some View {
        ChevronRightButton {
            
        }
    }
}
