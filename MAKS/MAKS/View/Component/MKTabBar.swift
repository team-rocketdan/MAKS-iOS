//
//  MKTabBar.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

/// TabBar selectedIndex에 따라 선택된 뷰를 표시하기 위한 열거형입니다.
enum TabBarIndex: Int {
    case home = 0
    case search = 1
    case order = 2
    case myPage = 3
}

struct MKTabBar: View {
    
    @Binding var selectedIndex: Int
    
    var focusedTab: TabBarIndex {
        TabBarIndex(rawValue: selectedIndex) ?? .home
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 60) {
                homeTabButton
                
                searchTabButton
                
                orderListTabButton
                
                myPageTabButton
            }
            
            Spacer()
            
        }
        .padding(.vertical, 15)
        .padding(.bottom, 7)
        .padding(.horizontal, 40)
        .frame(width: UIScreen.screenWidth)
        .frame(minHeight: 72)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .tabBarShadowColor,
                radius: 12)
    }
    
    //MARK: - homeTabButton
    
    private var homeTabButton: some View {
        Button {
            // navigate to homeTab
            selectedIndex = TabBarIndex.home.rawValue
        } label: {
            VStack {
                Image("home.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 26,
                           height: 26)
                    .foregroundColor(focusedTab == .home ? .mkMainColor : .mkGray300)
                
                Text("홈")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(focusedTab == .home ? .mkMainColor : .mkGray300)
            }
        }
    } // - homeTabButton
    
    //MARK: - searchTabButton
    
    private var searchTabButton: some View {
        Button {
            // navigate to searchTab
            selectedIndex = TabBarIndex.search.rawValue
        } label: {
            VStack {
                Image("search.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 26,
                           height: 26)
                    .foregroundColor(focusedTab == .search ? .mkMainColor : .mkGray300)
                Text("검색")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(focusedTab == .search ? .mkMainColor : .mkGray300)
            }
        }
    } // - searchTabButton
    
    //MARK: - orderListTabButton
    
    private var orderListTabButton: some View {
        Button {
            // navigate to orderListTab
            selectedIndex = TabBarIndex.order.rawValue
        } label: {
            VStack {
                Image("document.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 26,
                           height: 26)
                    .foregroundColor(focusedTab == .order ? .mkMainColor : .mkGray300)
                Text("주문내역")
                    .font(.system(size: 10,
                                  weight: .semibold))
                    .foregroundColor(focusedTab == .order ? .mkMainColor : .mkGray300)
            }
        }
    } // - orderListTabButton
    
    //MARK: - myPageTabButton
    
    private var myPageTabButton: some View {
        Button {
            // navigate to myPageTab
            selectedIndex = TabBarIndex.myPage.rawValue
        } label: {
            VStack(alignment: .center) {
                Image("person.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 26,
                           height: 26)
                    .foregroundColor(focusedTab == .myPage ? .mkMainColor : .mkGray300)
                Text("마이")
                    .font(.system(size: 10,
                                  weight: .semibold))
                    .foregroundColor(focusedTab == .myPage ? .mkMainColor : .mkGray300)
            }
        }
    } // - myPageTabButton
}
