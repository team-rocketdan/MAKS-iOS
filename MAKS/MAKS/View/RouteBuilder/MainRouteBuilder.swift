//
//  MainRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct MainRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.mainRouterView.rawValue }
    
    var build: (LinkNavigatorType, [String : String], DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                MainRouteView(navigator: navigator,
                              navigationViewModel: .init(navigator: navigator))
            }
        }
    }
}
