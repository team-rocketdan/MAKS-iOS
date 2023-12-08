//
//  AppRouterGroup.swift
//  MAKS
//
//  Created by sole on 11/13/23.
//

import LinkNavigator

struct AppRouterGroup {
    var routers: [RouteBuilder] {
        [
        LoginRouteBuilder(),
        MainRouteBuilder(),
        SearchRouteBuilder(),
        CartRouteBuilder(),
        PayRouteBuilder(),
        MarketDetailRouteBuilder(),
        SearchResultRouteBuilder(),
        OrderCompleteRouteBuilder()
        ]
    }
}
