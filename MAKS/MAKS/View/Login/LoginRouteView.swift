//
//  LoginRouteView.swift
//  MAKS
//
//  Created by sole on 2023/09/29.
//

import SwiftUI

struct LoginRouteView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    
    var body: some View {
        if userViewModel.isLogin {
            MainRouteView()
        } else {
           LoginView()
        }
    }
}
