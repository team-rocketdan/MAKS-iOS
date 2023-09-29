//
//  MAKSApp.swift
//  MAKS
//
//  Created by sole on 2023/08/29.
//

import SwiftUI
import NMapsMap

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        NMFAuthManager.shared().clientId = Bundle.main.infoDictionary?["NMFClientID"] as? String ?? "unknown"

       return true
    }
}


@main
struct MAKSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var userViewModel: UserViewModel = .init()
    @StateObject var marketViewModel: MarketViewModel = .init()
    @StateObject var menuViewModel: MenuViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            LoginRouteView()
                .accentColor(.mkMainColor)
                .environmentObject(userViewModel)
                .environmentObject(marketViewModel)
                .environmentObject(menuViewModel)
        }
    }
}
