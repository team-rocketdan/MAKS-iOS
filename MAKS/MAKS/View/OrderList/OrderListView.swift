//
//  OrderListView.swift
//  MAKS
//
//  Created by sole on 2023/09/01.
//

import SwiftUI
import LinkNavigator

struct OrderListView: View {
    let navigator: LinkNavigatorType
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("주문내역")
                .font(.system(size: 24,
                              weight: .bold))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(orderViewModel.orderedList, id: \.id) { order in
                        Button {
                            // navigate to detail view
                            navigator.next(paths: [],
                                           items: [:],
                                           isAnimated: true)
                        } label: {
                            OrderRowView(order: order)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.top, 20)
        }
        .onAppear {
            Task {
                do {
                    try await orderViewModel.fetchOrdersWithUserID(userID: userViewModel.currentUser?.id.uuidString ?? "2A13752F-92CC-4A31-9E11-4FAE61FCFC5D")
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
