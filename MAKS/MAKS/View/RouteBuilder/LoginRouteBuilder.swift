//
//  LoginRouteBuilder.swift
//  MAKS
//
//  Created by sole on 11/13/23.
//
import SwiftUI
import LinkNavigator

struct LoginRouteBuilder: RouteBuilder {
    var matchPath: String { RouteMatchPath.loginView.rawValue }
    
    var build: (LinkNavigatorType, [String : String], DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            return WrappingController(matchPath: matchPath) {
                LoginView(navigator: navigator)
            }
        }
    }
}
