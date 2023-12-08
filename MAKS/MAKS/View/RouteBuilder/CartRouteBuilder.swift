//
//  SearchRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct CartRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.cartView.rawValue }
    
    var build: (LinkNavigatorType,
                [String : String],
                DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                CartView(navigator: navigator)
            }
        }
    }
}
