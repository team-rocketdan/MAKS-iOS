//
//  PayRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct PayRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.payView.rawValue }
    
    var build: (LinkNavigatorType,
                [String : String],
                DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                PaymentView(navigator: navigator,
                            order: .defaultModel)
            }
        }
    }
}
