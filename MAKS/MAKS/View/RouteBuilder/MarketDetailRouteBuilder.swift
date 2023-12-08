//
//  MarketDetailRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct MarketDetailRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.marketDetailView.rawValue }
    
    var build: (LinkNavigatorType,
                [String : String],
                DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                MarketDetailView(navigator: navigator,
                                 marketID: items["marketID"] ?? "")
            }
        }
    }
}
