//
//  SearchRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct SearchRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.searchView.rawValue }
    
    var build: (LinkNavigatorType,
                [String : String],
                DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                SearchView(navigator: navigator)
            }
        }
    }
}
