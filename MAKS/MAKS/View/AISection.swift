//
//  AISection.swift
//  MAKS
//
//  Created by sole on 2023/10/18.
//

import SwiftUI
import LinkNavigator

struct AISection: View {
    let navigator: LinkNavigatorType
    
    @EnvironmentObject var sttRecognizer: SpeechRecognizer
    @EnvironmentObject var gpt: ChatGPTViewModel
    @EnvironmentObject var tts: TextToSpeech
    @EnvironmentObject var menuViewModel: MenuViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel 
    
    @State var sttTimer: Timer?
    
    var body: some View {
        HStack {
            VStack(spacing: 5) {
                if !gpt.parsedText.isEmpty {
                    STTTalkedTextBubble(text: $gpt.parsedText)
                }
                
                if !sttRecognizer.talkedText.isEmpty {
                    STTTalkedTextBubble(text: $sttRecognizer.talkedText)
                }
            }
            Spacer()
            
            VStack(spacing: 10) {
                MKSendButton(isActive: $sttRecognizer.isActiveSTTService) {
                    requestGPTService()
                }
                
                
                MKFloatingButton(isActive: $sttRecognizer.isActiveSTTService) {
                    sttRecognizer.isActiveSTTService.toggle()
                    sttService()
                }
            }
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
        //MARK: - onAppear
        .onAppear {
            sttRecognizer.startTranscribing()
        }
//        .onDisappear() {
//            
//            print("")
//            sttRecognizer.stopTranscribing()
//        }
        //MARK: - onChange(sttRecognizer.isActiveSTTService)
        .onChange(of: sttRecognizer.isActiveSTTService) { isActive in
            guard isActive
            else {
                sttRecognizer.talkedText.removeAll()
                return
            }
            sttRecognizer.transcript.removeAll()
            startTimer()
        }
        //MARK: - onChange(sttRecognizer.talkedText)
        .onChange(of: sttRecognizer.talkedText) { newValue in
            guard !newValue.isEmpty
            else { return }
            
            /// 3초 이상 묵음이면 자동으로 gpt에 request를 전송합니다.
            resetTimer()
        }
        .onChange(of: tts.delegate.isActive) { newValue in
            guard !newValue
            else { return }
            
            gpt.parsedText = ""
        }
        //MARK: - onChange(sttRecognizer.transcript)
        .onChange(of: sttRecognizer.transcript) { newValue in
            /// 빈 문자열인 경우 실행하지 않습니다.
            guard !newValue.isEmpty
            else { return }
            
            guard newValue.contains("마크")
            else {
                /// 300자 이상이면 flush 합니다.
                if newValue.count > 300 {
                    sttRecognizer.transcript.removeAll()
                }
                return
            }
            sttRecognizer.transcript.removeAll()
            sttRecognizer.resetTranscript()
            sttRecognizer.startTranscribing()
            sttRecognizer.isActiveSTTService = true
        }
        //MARK: - onChange(gpt.response)
        .onChange(of: gpt.response) { newValue in
            //FIXME: 동일한 명령어 입력시 입력을 감지하지 못하는 문제
            guard !newValue.isEmpty
            else { return }
            gpt.parsedText = commandGPT(response: newValue)
            
            guard !gpt.parsedText.isEmpty
            else { return }
            tts.startTTS(message: gpt.parsedText)
        }
    }
    
    //MARK: - commandGPT
    // Order
    // Pay
    // Question
    // Error
    //
    /// 응답에 따라 뷰를 조작합니다.
    ///
    ///
    func commandGPT(response: String) -> String {
        let parsedText = response.split(separator: "#")
        
        guard parsedText.count > 0
        else {
//            gpt.response.removeAll()
            return ""
        }
        
        let command = parsedText[0]
        
        switch command {
        case "Navigate":
            guard parsedText.count > 1
            else {
                break
            }
            
            if parsedText[1].contains("장바구니") {
                navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                          RouteMatchPath.mainRouterView.rawValue,
                                          RouteMatchPath.cartView.rawValue],
                                  items: [:],
                                  isAnimated: true)
            }
            else if parsedText[1].contains("검색") {
                navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                          RouteMatchPath.mainRouterView.rawValue,
                                          RouteMatchPath.searchView.rawValue],
                                  items: [:],
                                  isAnimated: true)
            }
            else if parsedText[1].contains("가게") || parsedText[1].contains("햄버거") {
                navigator.next(paths: [RouteMatchPath.marketDetailView.rawValue],
                               items: ["marketID": Market.defaultModel.id.uuidString], isAnimated: true)
            }
            else if parsedText[1].contains("결제") {
                navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                          RouteMatchPath.mainRouterView.rawValue,
                                          RouteMatchPath.orderComplete.rawValue],
                                  items: [:],
                                  isAnimated: true)
            }
            
        case "Move":
            guard parsedText.count > 1
            else {
                break
            }
            if parsedText[1].contains("장바구니") {
                navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                          RouteMatchPath.mainRouterView.rawValue,
                                          RouteMatchPath.cartView.rawValue],
                                  items: [:],
                                  isAnimated: true)
            }
            else if parsedText[1].contains("결제") {
                navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                          RouteMatchPath.mainRouterView.rawValue,
                                          RouteMatchPath.orderComplete.rawValue],
                                  items: [:],
                                  isAnimated: true)
            }
            else if parsedText[1].contains("가게") || parsedText[1].contains("햄버거") {
                navigator.next(paths: [RouteMatchPath.marketDetailView.rawValue],
                               items: ["marketID": Market.defaultModel.id.uuidString], isAnimated: true)
            }
        case "Order":
            navigator.next(paths: [RouteMatchPath.payView.rawValue],
                           items: ["marketID": Market.defaultModel.id.uuidString], isAnimated: true)
        case "Pay":
            guard parsedText.count > 1
            else {
                break
            }
            
            if parsedText[1].contains("네이버") {
                sttRecognizer.pay = "네이버"
            } else if parsedText[1].contains("토스") {
                sttRecognizer.pay = "토스"
            } else if parsedText[1].contains("신용") ||  parsedText[1].contains("카드"){
                sttRecognizer.pay = "신용"
            } else if parsedText[1].contains("카카오") {
                sttRecognizer.pay = "카카오"
            }
            
            navigator.replace(paths: [RouteMatchPath.loginView.rawValue,
                                      RouteMatchPath.mainRouterView.rawValue,
                                      RouteMatchPath.orderComplete.rawValue],
                                    items: [:],
                                    isAnimated: true)
            
        case "Error":
            break
        case "Customer":
            break
        case "Question":
            break
        case "Add":
            guard parsedText.count > 1
            else {
                break
            }
            
            if parsedText[1].contains("치즈") || parsedText[1].contains("버거") {
                guard let menu = menuViewModel.menuIDs["A9169F66-9732-438D-BF2D-CB98EC9DFB6B"]
                else { break }
                menuViewModel.menusInCart[menu, default: 0] += 1
            } else if parsedText[1].contains("콜라") {
                    guard let menu = menuViewModel.menuIDs["EB1E5ECC-E36B-4C89-8EBC-FE5FF79F6ED9"]
                    else { break }
                    menuViewModel.menusInCart[menu, default: 0] += 1
            } else if parsedText[1].contains("감자") || parsedText[1].contains("튀김") {
                    guard let menu = menuViewModel.menuIDs["286457BB-6960-4B31-B6CF-6D41836ABC8A"]
                    else { break }
                    menuViewModel.menusInCart[menu, default: 0] += 1
                }
        case "Off":
            sttRecognizer.isActiveSTTService = false
        default:
            print("unknown command")
        }
//        gpt.response.removeAll()
        return String(parsedText.last!)
    }
    
    
    //MARK: - sttService
    
    func sttService() {
        sttRecognizer.resetTranscript()
        sttRecognizer.startTranscribing()
        sttRecognizer.transcript.removeAll()
        sttRecognizer.talkedText.removeAll()
        gpt.response.removeAll()
    }
    
    //MARK: - requestGPTService
    
    func requestGPTService() {
        guard !sttRecognizer.talkedText.isEmpty
        else { return }
        let request = GPTRequest(model: GPTRequest.modelName,
                                 messages: [GPTRequest.systemMessage,
                                            .init(role: "user",
                                                  content: sttRecognizer.talkedText)])
        /// 텍스트를 보낸 뒤 flush 합니다.
//        sttRecognizer.talkedText.removeAll()
        sttRecognizer.resetTranscript()
        sttRecognizer.startTranscribing()
        Task {
            do {
                let response = try await gpt.post(req: request)
                DispatchQueue.main.async {
                    gpt.response = response.choices[0].message.content
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Timer methods
    
    func startTimer() {
        // 입력이 없으면 3초 뒤 타이머를 끕니다.
        self.sttTimer = Timer.scheduledTimer(withTimeInterval: 3.0,
                                             repeats: false) { timer in
            requestGPTService()
            sttRecognizer.talkedText.removeAll()
            timer.invalidate()
//            /// STT 서비스를 종료합니다.
//            sttRecognizer.isActiveSTTService = false
  
        }
    }
    
    
    func resetTimer() {
        self.sttTimer?.invalidate()
        self.startTimer()
    }
}
