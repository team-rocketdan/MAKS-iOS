//
//  UserViewModel.swift
//  MAKS
//
//  Created by sole on 2023/09/12.
//

import SwiftUI
import LinkNavigator

class UserViewModel: ObservableObject {    
    let url: String = Bundle.main.infoDictionary?["ServerURL"] as? String ?? ""
    let apiManager = APIManager<User>()
    
    @Published var isLogin: Bool = false
    @Published var currentUser: User?
    
    func login() async throws {
//        let user = try await apiManager.get("\(url)/user")
        let user: User = .init(id: UUID(uuidString: "2A13752F-92CC-4A31-9E11-4FAE61FCFC5D") ?? UUID(),
                               firebaseID: "abcd",
                               name: "김이화",
                               email: "eee@ewhain.net",
                               loginCenter: LoginCenter.apple.rawValue,
                               createdAt: .init())
        DispatchQueue.main.async {
            self.currentUser = user
        }
    }
    
    func logout() {
        self.isLogin = false
    }
    
    
    
}
