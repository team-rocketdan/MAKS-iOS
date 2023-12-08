//
//  SearchView.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import SwiftUI
import LinkNavigator

struct SearchView: View {
    let navigator: LinkNavigatorType
    
    @Environment(\.dismiss) var dismiss
    
    @State var searchText: String = ""
    @State var isPresentedSearchResultView: Bool = false
   
//    @State var searchHistory: [String] = []
    
    @StateObject var searchHistoryClass = SearchHistory.shared
    
    let rankedFoodList = ["마라탕", "마라룽샤", "샌드위치",
                          "회", "돼지게티", "다이어트",
                          "라면","우유", "크로플", "와플"]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                titleSection
                
                VStack(alignment: .leading, spacing: 30) {
                    MKSearchBar(text: $searchText)
                        .padding(.horizontal, 20)
                    
                    recentSearchSection
                    
                    popularSearchSection
                }
                Spacer()
                
                    .navigationBarBackButtonHidden(true)
            }
            
            AISection(navigator: navigator)
                .offset(y: 300)
        }
//        .navigationDestination(isPresented: $isPresentedSearchResultView) {
//            SearchResultView(searchText: $searchText)
//        }
        .onAppear {
            // sync를 맞춤.
            searchHistoryClass.searchHistory = searchHistoryClass.userDefaultsArray
            // UserDefaultsDidChange 알림을 구독
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(SearchHistory.userDefaultsDidChange),
                                                   name: UserDefaults.didChangeNotification,
                                                   object: nil)
        }
        .onDisappear {
            // NotificationCenter에서 알림 구독 해제
            NotificationCenter.default.removeObserver(self,
                                                      name: UserDefaults.didChangeNotification,
                                                      object: nil)

        }
        .onChange(of: searchHistoryClass.userDefaultsArray) { newArray in
            
        }
        .onSubmit {
//            isPresentedSearchResultView = true
            navigator.next(paths: [RouteMatchPath.searchResultView.rawValue],
                           items: ["searchText" : searchText],
                           isAnimated: true)
            addSearchHistory()
            searchHistoryClass.setUserDefaultsWithSearchHistory()
        }
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack(spacing: 0) {
            Button {
                dismiss()
            } label: {
                Image("chevron.left")
                    .renderingMode(.template)
                    .foregroundColor(.mkMainColor)
            }
            .padding(.trailing, 126)
            
            
            Text("검색")
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
                
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    } // titleSection
    
    //MARK: - recentSearchSection
    
    private var recentSearchSection: some View {
        VStack(alignment: .leading) {
            Text("최근 검색어")
                .foregroundColor(.mkMainColor)
                .font(.system(size: 20, weight: .bold))
            
            HStack(spacing: 10) {
                ForEach(searchHistoryClass.searchHistory, id: \.self) { history in
                    MKSearchChip(text: history) {
                        searchText = history
                    }
                }
            }
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    } // - recentSearchSection
    
    //MARK: - popularSearchSection
    
    private var popularSearchSection: some View {
        VStack(alignment: .leading) {
            Text("인기 검색어")
                .foregroundColor(.mkMainColor)
                .font(.system(size: 20, weight: .bold))
            
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<5) { index in
                        Button {
                            print("\(rankedFoodList[index])")
                            searchText.removeAll()
                            searchText = rankedFoodList[index]
                        } label: {
                            HStack(spacing: 4) {
                                Text("\(index + 1)")
                                
                                Text(" \(rankedFoodList[index])")
                                    .padding(.vertical, 10)
                                
                                Spacer()
                            }
                            .font(.system(size: 16, weight: .light))
                        }
                        
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(5..<10) { index in
                        Button {
                            print("\(rankedFoodList[index])")
                            searchText.removeAll()
                            searchText = rankedFoodList[index]
                        } label: {
                            HStack(spacing: 4) {
                                Text("\(index + 1)")
                                
                                Text(" \(rankedFoodList[index])")
                                    .padding(.vertical, 10)
                                
                                Spacer()
                            }
                            .font(.system(size: 16, weight: .light))
                        }
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    } // - popularSearchSection
    
    //MARK: - addSearchHistory
    
    func addSearchHistory() {
        /// 빈 텍스트는 검색결과에 추가하지 않습니다. 
        guard !searchText.isEmpty
        else { return }
        /// 이미 검색 결과에 있는 텍스트는 추가하지 않습니다.
        guard !searchHistoryClass.searchHistory.contains(searchText)
        else { return }
        if searchHistoryClass.searchHistory.count > 10 {
            searchHistoryClass.searchHistory.removeFirst()
        }
        searchHistoryClass.searchHistory.append(searchText)
    }
}

