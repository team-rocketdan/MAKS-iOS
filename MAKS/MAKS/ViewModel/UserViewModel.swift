//
//  UserViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    @Published var currentUser: User?
    
    func login() {
        self.isLogin = true
        DispatchQueue.main.async {
            self.currentUser = .defaultModel
        }
    }
    
    func logout() {
        self.isLogin = false
    }
    
    
    
}
