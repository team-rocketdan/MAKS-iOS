//
//  MyPageView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    let textPadding: CGFloat  = 15
    // FIXME: user data로 수정해야 함. 
    let name: String = "마크"
    let email: String = "mark@gmail.com"
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    private let sectionTitle: [String] = ["공지사항",
                                  "문의하기",
                                  "약관 및 정책",
                                  "환경설정"]
    
    var body: some View {
        VStack(spacing: 0) {
            sectionOfTitle
            
            Button {
                print("navigate to mypage")
            } label: {
                sectionOfUserInformation
            }

            sectionOfDivider
                
            sectionOfNavigations
                
            sectionOfVersion
            
            sectionOfDivider
            
            sectionOfLogOut
            
            Spacer()

        }
    }
    
    //MARK: - sectionOfTitle
    
    private var sectionOfTitle: some View {
        HStack {
            Text("마이페이지")
                .font(.system(size: 24,
                              weight: .bold))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    } // - sectionOfTitle
    
    //MARK: - sectionOfUserInformation
    
    private var sectionOfUserInformation: some View {
        HStack {
            // FIXME: 유저 이미지로 교체
            Image.imagePlaceHolder
                .resizable()
                .frame(width: 60,
                       height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading,
                   spacing: 10) {
                Text(userViewModel.currentUser?.name ?? User.defaultModel.name)
                    .font(.system(size: 20,
                                  weight: .bold))
                Text(userViewModel.currentUser?.email ?? User.defaultModel.email)
                    .font(.system(size: 14))
                    .foregroundColor(.mkEmailGray)
            }
            
            Spacer()
            
            Image("chevron.right")
                .renderingMode(.template)
                .foregroundColor(.mkGray500)
        }
        .padding(20)
        .background(Color.white)
    } // - sectionOfUserInformation
    
    //MARK: - sectionOfDivider
    
    private var sectionOfDivider: some View {
        VStack(spacing: 0) {
        }
        .frame(width: UIScreen.screenWidth,
               height: 10)
        .background(Color.mkGray100)
    } // - sectionOfDivider
    
    //MARK: - sectionOfNavigations
    private var sectionOfNavigations: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            ForEach(sectionTitle, id: \.self) { title in
                MyPageSectionRow(title: title) {
                    // navigate to detail view
                }
                .background(Color.white)
                .onTapGesture {
                    print("tap navigation")
                }
                Divider()
            }
        }
    } // - sectionOfNavigations
    
    //MARK: - sectionOfVersion
    
    private var sectionOfVersion: some View {
        HStack {
            Text("현재 버전: \(version)")
                .font(.system(size: 18,
                              weight: .medium))
            Spacer()
        }
        .padding(.vertical, textPadding)
        .padding(.horizontal, 20)
    } // - sectionOfVersion
    
    //MARK: - sectionOfLogOut
    
    private var sectionOfLogOut: some View {
        HStack {
            
            Spacer()
            
            Button {
                print("logout")
                userViewModel.isLogin = false
            } label: {
                Text("로그아웃")
                    .underline()
                    .foregroundColor(.mkSubColor)
            }
        }
        .padding(.top, 10)
        .padding(.trailing, 20)
    } // - sectionOfLogOut
}

//MARK: - MyPageSectionRow

struct MyPageSectionRow: View {
    let textPadding: CGFloat  = 15
    let title: String
    let action: () -> (Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
    
    //MARK: - label 
    
    var label: some View {
        HStack {
            Text(title)
                .font(.system(size: 18,
                              weight: .medium))
                
            Spacer()
            
            Image("chevron.right")
                .renderingMode(.template)
                .foregroundColor(.mkGray500)
        }
        .padding(.vertical, textPadding)
        .padding(.horizontal, 20)
    }
}
