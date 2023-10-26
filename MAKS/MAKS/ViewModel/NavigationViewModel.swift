//
//  NavigationViewModel.swift
//  MAKS
//
//  Created by sole on 2023/10/20.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var isPresentedSearchView: Bool = false
    @Published var isPresentedMainRouteView: Bool = false
    @Published var isPresentedMarketView: Bool = false
    @Published var isPresentedCartView: Bool = false
    @Published var isPresentedPaymentView: Bool = false
    @Published var isPresentedOrderCompleteView: Bool = false
    
    @Published var isOrder: Bool = false
    
    @Published var isPresentedMyPageView: Bool = false
    @Published var isPresentedOrderListView: Bool = false
}
