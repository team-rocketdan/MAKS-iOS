//
//  OrderViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orderedList: [Order] = []
    
    @Published var menusInCart: [Menu] = []
    
    
}
