//
//  MyPageView.swift
//  MAKS
//
//  Created by sole on 2023/08/30.
//

import SwiftUI

struct MyPageView: View {
    // FIXME: user data로 수정해야 함. 
    let name: String = "마크"
    let email: String = "mark@gmail.com"
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
    }
    
    private let sectionTitle: [String] = ["공지사항",
                                  "자주 묻는 질문",
                                  "이벤트",
                                  "고객센터",
                                  "환경설정",
                                  "약관 및 정책"]
    
    var body: some View {
        VStack(spacing: 0) {

            sectionOfTitle
            
            sectionOfUserInformation
                
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
            Image("star.fill")
                .resizable()
                .frame(width: 60,
                       height: 60)
                .background(Color.green)
                .clipShape(Circle())
            
            VStack(alignment: .leading,
                   spacing: 10) {
                Text(name)
                    .font(.system(size: 20,
                                  weight: .bold))
                Text(email)
                    .font(.system(size: 14))
                    .foregroundColor(.mkEmailGray)
            }
            
            Spacer()
            
            ChevronRightButton {
                print("navigate to detail view")
            }
        }
        .padding(20)
    } // - sectionOfUserInformation
    
    //MARK: - sectionOfDivider
    
    private var sectionOfDivider: some View {
        VStack {
            EmptyView()
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
                    print("navigate to section")
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
        .padding(20)
    } // - sectionOfVersion
    
    //MARK: - sectionOfLogOut
    
    private var sectionOfLogOut: some View {
        HStack {
            Spacer()
            
            Button {
                print("logout")
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
    let title: String
    let action: () -> ()
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18,
                              weight: .medium))
                
            Spacer()
            
            ChevronRightButton {
                action()
            }
        }
        .padding(20)
    }
}
