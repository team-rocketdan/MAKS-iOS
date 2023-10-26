//
//  PaymentView.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI
import AlertToast

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    let paymentMethodStrings = ["신용카드 결제", "카카오페이", "네이버페이", "토스페이"]
    let paymentImageStrings = ["", "kakao", "naver", "toss"]
    
    @State var isOnArray: [Bool] = [false, false, false, false]
    @State var isPresentedOrderCompleteView: Bool = false
    
    let order: Order
    let totalPayment: Int
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,
                   spacing: 0) {
                titleSection
                    .padding(.horizontal, 20)
                
                Text("결제수단")
                    .font(.system(size: 20,
                                  weight: .bold))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                
                ForEach(0..<paymentMethodStrings.count) { index in
                    Divider()
                    paymentRowView(paymentIndex: index)
                        .padding(.horizontal, 20)
                }
                
                SectionDivider()
                
                totalOrderSection
                    .padding(.horizontal, 20)
                
                Divider()
                
                totalPaymentSection
                    .padding(.horizontal, 20)
                
                SectionDivider()
                
                Spacer()
                
                MKButton(style: .plain) {
                    requestOrder()
                } label: {
                    Text("결제하기")
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                
                .navigationBarBackButtonHidden(true)
            }
            
            AISection()
                .offset(y: 250)
        }
        .navigationDestination(isPresented: $isPresentedOrderCompleteView) {
                   OrderCompleteView()
                .environmentObject(alertToastViewModel)
               }
        .toast(isPresenting: $alertToastViewModel.isProcessing) {
            AlertToast(displayMode: .alert, type: .loading)
        }
        .onChange(of: navigationViewModel.isOrder) { newValue in
            guard newValue
            else { return }
            requestOrder()
        }
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        HStack(spacing: 110) {
            Button {
                dismiss()
            } label: {
                Image("chevron.left")
            }
            
            Text("결제하기")
                .font(.system(size: 24,
                              weight: .bold))
            
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
    
    //MARK: - paymentRowView
    
    private func paymentRowView(paymentIndex: Int) -> some View {
        HStack(spacing: 10) {
            RadioButton(isOn: $isOnArray[paymentIndex]) {
                selectRadioButton(index: paymentIndex)
            }
            Text(paymentMethodStrings[paymentIndex])
                .foregroundColor(isOnArray[paymentIndex] ? .mkMainColor : .mkGray300)
                .font(.system(size: 18,
                              weight: .medium))
            
            
            Spacer()
            
            Image("\(paymentImageStrings[paymentIndex])")
        }
        .padding(.vertical, 20)
        .onTapGesture {
            selectRadioButton(index: paymentIndex)
        }
    }
    
    //MARK: - totalOrderSection
    
    private var totalOrderSection: some View {
        HStack(spacing: 0) {
            Text("총 주문금액")
            
            Spacer()
            
            Text("\(totalPayment)원")
        }
        .font(.system(size: 18,
                      weight: .medium))
        .padding(.vertical, 20)
    }
    
    //MARK: - totalPaymentSection
    
    private var totalPaymentSection: some View {
        HStack(spacing: 0) {
            Text("결제금액")
            
            Spacer()
            
            Text("\(totalPayment)원")
        }
        .font(.system(size: 18,
                      weight: .bold))
        .padding(.vertical, 20)
    }
    
    //MARK: - toggleRadioButton
    
    func selectRadioButton(index: Int) {
        isOnArray = [false, false, false, false]
        isOnArray[index] = true
    }
    
    
    func requestOrder() {
        Task {
            do {
                alertToastViewModel.isProcessing = true
                try await orderViewModel.registerOrder(order: self.order)
                menuViewModel.menusInCart.removeAll()
                alertToastViewModel.isProcessing = false
                isPresentedOrderCompleteView = true
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
