//
//  MKStepper.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI

struct MKStepper: View {
    @Binding var count: Int

    var body: some View {
        HStack(spacing: 10) {
            Button {
                subtractCount()
            } label: {
                Image("remove.circle.fill")
                    .resizable()
                    .frame(width: 20,
                           height: 20)
            }
            
            Text("\(count)")
                .font(.system(size: 20,
                              weight: .medium))
                .foregroundColor(.mkMainColor)
            
            Button {
                addCount()
            } label: {
                Image("add.circle.fill")
                    .resizable()
                    .frame(width: 20,
                           height: 20)
            }
        }
    }
    
    private func addCount() {
        self.count += 1
    }
    
    private func subtractCount() {
        guard self.count > 1
        else { return }
        self.count -= 1
    }
}

//MARK: - Previews

struct MKStepper_Previews: PreviewProvider {
    static var previews: some View {
        MKStepper(count: .constant(0))
    }
}
