//
//  MainRouteView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI
import AlertToast

struct MainRouteView: View {
    @EnvironmentObject var tts: TextToSpeech
    @EnvironmentObject var sttRecognizer: SpeechRecognizer
    @EnvironmentObject var gpt: ChatGPTViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var menuViewModel: MenuViewModel
    
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
            return AnyView(HomeView())
        case .order:
            return AnyView(OrderListView())
        case .myPage:
            return AnyView(MyPageView())
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
                    
                    AISection()
                    
                    MKTabBar(selectedIndex: $selectedIndex)
                        .ignoresSafeArea()
                        .frame(maxHeight: 72)
                }
            }
            //FIXME: navigation Stack을 모두 pop하는 방식으로 변경해야 함.
            .navigationBarBackButtonHidden(true)
            
            //MARK: - navigationDestination(SearchView)
            .navigationDestination(isPresented: $navigationViewModel.isPresentedSearchView) {
                SearchView()
                    .padding(.bottom, 75)
                    .environmentObject(alertToastViewModel)
                    .environmentObject(navigationViewModel)
            }
            //MARK: - navigationDestination(CartView)
            .navigationDestination(isPresented: $navigationViewModel.isPresentedCartView) {
                CartView()
                    .environmentObject(alertToastViewModel)
                    .environmentObject(navigationViewModel)
            }
        }
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


