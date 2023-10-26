//
//  MAKSApp.swift
//  MAKS
//
//  Created by sole on 2023/08/29.
//

import SwiftUI
import NMapsMap
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        NMFAuthManager.shared().clientId = Bundle.main.infoDictionary?["NMFClientID"] as? String ?? "unknown"
        FirebaseApp.configure()
        
       return true
    }
}


@main
struct MAKSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var userViewModel: UserViewModel = .init()
    @StateObject var marketViewModel: MarketViewModel = .init()
    @StateObject var menuViewModel: MenuViewModel = .init()
    @StateObject var orderViewModel: OrderViewModel = .init()
    @StateObject var textToSpeech: TextToSpeech = .init()
    @StateObject var speechRecognizer: SpeechRecognizer = .init()
    @StateObject var chatGPTViewModel: ChatGPTViewModel = .init()
    @StateObject var alertToastViewModel: AlertToastViewModel = .init()
    @StateObject var navigationViewModel: NavigationViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            LoginRouteView()
                .accentColor(.mkMainColor)
                .environmentObject(userViewModel)
                .environmentObject(marketViewModel)
                .environmentObject(menuViewModel)
                .environmentObject(orderViewModel)
                .environmentObject(speechRecognizer)
                .environmentObject(chatGPTViewModel)
                .environmentObject(textToSpeech)
                .environmentObject(alertToastViewModel)
                .environmentObject(navigationViewModel)
        }
    }
}
