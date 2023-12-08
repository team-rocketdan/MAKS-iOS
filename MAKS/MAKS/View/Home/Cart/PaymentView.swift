//
//  PaymentView.swift
//  MAKS
//
//  Created by sole on 2023/10/02.
//

import SwiftUI
import AlertToast
import LinkNavigator

struct PaymentView: View {
    let navigator: LinkNavigatorType
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var alertToastViewModel: AlertToastViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var sttRecognizer: SpeechRecognizer
    
    let paymentMethodStrings = ["신용카드 결제", "카카오페이", "네이버페이", "토스페이"]
    let paymentImageStrings = ["", "kakao", "naver", "toss"]
    
    @State var isOnArray: [Bool] = [false, false, false, false]
    @State var isPresentedOrderCompleteView: Bool = false
    
    @State var order: Order = .defaultModel
    
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
            
            AISection(navigator: navigator)
                .offset(y: 250)
        }
        .onAppear {
            self.order = orderViewModel.cartOrder ?? .defaultModel
        }
//        .navigationDestination(isPresented: $isPresentedOrderCompleteView) {
//                   OrderCompleteView()
//                .environmentObject(alertToastViewModel)
//               }
        .toast(isPresenting: $alertToastViewModel.isProcessing) {
            AlertToast(displayMode: .alert, type: .loading)
        }
        .onChange(of: sttRecognizer.pay) { newValue in
            guard !newValue.isEmpty
            else { return }
            if newValue.contains("네이버") {
                selectRadioButton(index: 2)
            } else if newValue.contains("신용") || newValue.contains("카드") {
                selectRadioButton(index: 0)
            } else if newValue.contains("토스") {
                selectRadioButton(index: 3)
            } else if newValue.contains("카카오") {
                selectRadioButton(index: 1)
            }
        }
//        .onChange(of: navigationViewModel.isOrder) { newValue in
//            guard newValue
//            else { return }
//            requestOrder()
//        }
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
            
            Text("\(menuViewModel.totalPayment)원")
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
            
            Text("\(menuViewModel.totalPayment)원")
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
                navigator.next(paths: [RouteMatchPath.orderComplete.rawValue],
                               items: [:],
                               isAnimated: true)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
