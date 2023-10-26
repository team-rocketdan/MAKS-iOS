//
//  OrderCompleteView.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI
import AlertToast

//FIXME: dismiss시 naviagation에 쌓인 stack을 모두 pop하도록 수정
struct OrderCompleteView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @State var isPresentedMainRouteView: Bool = false
    
    let orderNumber: Int = 101
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            titleSection
            
            VStack(alignment: .leading,
                   spacing: 20) {
                Text("결제가 완료되었습니다.")
                    .font(.system(size: 20,
                                  weight: .bold))
                
                Text("가게에서 접수 확인 중이니\n잠시만 기다려주세요!")
                    .font(.system(size: 16,
                                  weight: .medium))
            }
            .padding(.vertical, 10)
            .padding(.bottom, 20)
            
            orderNumberSection
            
            Spacer()
            
            MKButton(style: .plain) {
//                dismiss()
                navigationViewModel.isPresentedMainRouteView = true
            } label: {
                Text("확인")
                    .frame(maxWidth: .infinity)
            }
            
            .navigationBarBackButtonHidden(true)
        }
        .padding(.horizontal, 20)
        .navigationDestination(isPresented: $navigationViewModel.isPresentedMainRouteView) {
            MainRouteView()
                .environmentObject(alertToastViewModel)
        }
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack(spacing: 110) {
            Spacer()
            
            Text("결제완료")
                .font(.system(size: 24,
                              weight: .bold))
            
            Button {
//                dismiss()
                isPresentedMainRouteView = true
            } label: {
                Image("close")
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
    //MARK: - orderNumberSection
    
    private var orderNumberSection: some View {
        VStack {
            Text("주문번호")
                .font(.system(size: 20,
                              weight: .bold))
            Text("\(orderNumber)")
                .font(.system(size: 84,
                              weight: .bold))
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(maxWidth: .infinity)
        .background(Color.mkMainColor)
        .cornerRadius(8)
        
    }
}


//MARK: - Previews

#Preview {
    OrderCompleteView()
}
