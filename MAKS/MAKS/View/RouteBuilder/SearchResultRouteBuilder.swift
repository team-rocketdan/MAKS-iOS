//
//  SearchResultRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/14/23.
//

import SwiftUI
import LinkNavigator

struct SearchResultRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.searchResultView.rawValue }
    
    var build: (LinkNavigatorType,
                [String : String],
                DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                SearchResultView(navigator: navigator,
                                 searchText: "\(items["searchText"] ?? "")")
            }
        }
    }
}
