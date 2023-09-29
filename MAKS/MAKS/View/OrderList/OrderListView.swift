//
//  OrderListView.swift
//  MAKS
//
//  Created by sole on 2023/09/01.
//

import SwiftUI

struct OrderListView: View {
    var body: some View {
        VStack {
            Text("주문내역")
                .font(.system(size: 24,
                              weight: .bold))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(0..<10) { _ in
                        Button {
                            // navigate to detail view
                        } label: {
                            OrderRowView()
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}
