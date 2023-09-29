//
//  SearchView.swift
//  MAKS
//
//  Created by sole on 2023/09/02.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var searchText: String = ""
    @State var isPresentedSearchResultView: Bool = false
    
    let rankedFoodList = ["마라탕", "마라룽샤", "샌드위치",
                          "회", "돼지게티", "다이어트",
                          "라면","우유", "크로플", "와플"]
    
    var body: some View {
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
        .navigationDestination(isPresented: $isPresentedSearchResultView) {
            SearchResultView(searchText: $searchText)
        }
        .onSubmit {
            isPresentedSearchResultView = true
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
                ForEach(0..<3) { _ in
                    MKSearchChip(text: "크로플") {
                        searchText = "크로플"
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
}
