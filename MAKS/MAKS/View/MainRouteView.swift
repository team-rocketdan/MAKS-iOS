//
//  MainRouteView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI
import AlertToast
import LinkNavigator

struct MainRouteView: View {
    let navigator: LinkNavigatorType
    
    @StateObject var navigationViewModel: NavigationViewModel 
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var tts: TextToSpeech
    @EnvironmentObject var sttRecognizer: SpeechRecognizer
    @EnvironmentObject var gpt: ChatGPTViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var marketViewModel: MarketViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var chatGPTViewModel: ChatGPTViewModel
    
    
    @State var isPresentedCartView: Bool = false
    
    @State var selectedIndex: Int = 0
    
    @State var isPresentedSearchView: Bool = false
    
    /// 현재 보고 있는 Tab의 Index를 반환하는 변수입니다.
    var focusedTab: TabBarIndex {
        TabBarIndex(rawValue: selectedIndex) ?? .home
    }
    
    /// 현재 보고 있는 Tab의 View를 반환하는 변수입니다.
    var focusedView: some View {
        switch focusedTab {
        case .home, .search:
            return AnyView(HomeView(navigator: navigator))
        case .order:
            return AnyView(OrderListView(navigator: navigator))
        case .myPage:
            return AnyView(MyPageView(navigator: navigator))
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                focusedView
                    .padding(.bottom, 75)
                
                // TabBar and Floating Button Section
                VStack(spacing: 0) {
                    Spacer()
                    
                    AISection(navigator: navigator)
                    
                    MKTabBar(navigator: navigator,
                             selectedIndex: $selectedIndex)
                        .ignoresSafeArea()
                        .frame(maxHeight: 72)
                }
            }
        }
        .navigationBarHidden(true)
        .environmentObject(userViewModel)
        .environmentObject(marketViewModel)
        .environmentObject(menuViewModel)
        .environmentObject(orderViewModel)
        .environmentObject(sttRecognizer)
        .environmentObject(chatGPTViewModel)
        .environmentObject(tts)
        .environmentObject(alertToastViewModel)
        .environmentObject(navigationViewModel)
        .environmentObject(alertToastViewModel)
        .toast(isPresenting: $alertToastViewModel.isComplete) {
            AlertToast(displayMode: .alert, type: .complete(.green))
        }
        .toast(isPresenting: $alertToastViewModel.isError) {
            AlertToast(displayMode: .alert, type: .error(.red))
        }
        //MARK: - onChange(selectedIndex)
        .onChange(of: selectedIndex) { newValue  in
            if newValue == TabBarIndex.search.rawValue {
                navigationViewModel.isPresentedSearchView = true
                selectedIndex = TabBarIndex.home.rawValue
            }
        }
        .onAppear {
            fetchMenusInOrder()
        }
       
        /// tts가 작동되는 동안 말풍선을 띄웁니다.
    }
    //MARK: - Command method
    
    func fetchMenusInOrder() {
        Task {
            do {
                try await menuViewModel.fetchMenusInMarket(marketID: "24780C19-EFDA-4458-ACAA-1A3BF30AD1B9")
                for menu in menuViewModel.menus {
                    menuViewModel.menuIDs[menu.id.uuidString] = menu
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    
    func addMenu() {
        
    }
    
}


