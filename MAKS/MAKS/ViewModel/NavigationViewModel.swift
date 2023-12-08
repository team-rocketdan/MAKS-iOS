//
//  NavigationViewModel.swift
//  MAKS
//
//  Created by sole on 2023/10/20.
//

import SwiftUI
import LinkNavigator

class NavigationViewModel: ObservableObject {
    let navigator: LinkNavigatorType
    
    init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
    
    func navigateToSearchView() {
        navigateToMainView()
        navigator.next(paths: [RouteMatchPath.searchView.rawValue],
                       items: [:],
                       isAnimated: true)
    }
    
    func navigateToCartView() {
        navigateToMainView()
        navigator.next(paths: [RouteMatchPath.cartView.rawValue],
                       items: [:],
                       isAnimated: true)
    }
    
    func navigateToMainView() {
        navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                  RouteMatchPath.mainRouterView.rawValue
                                 ],
                          items: [:],
                          isAnimated: true)
    }
    
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
