//
//  AISection.swift
//  MAKS
//
//  Created by sole on 2023/10/18.
//

import SwiftUI

struct AISection: View {
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
            //                requestGPTService(message: sttRecognizer.talkedText)
        }
        .onChange(of: tts.delegate.isActive) { newValue in
            //FIXME: 자동으로 request 보낼 시 isActive 변경이 제대로 적용되지 않는 현상
            print("isActiveTTS", newValue)
            guard !newValue
            else { return }
            
            gpt.parsedText = ""
        }
        //MARK: - onChange(sttRecognizer.transcript)
        .onChange(of: sttRecognizer.transcript) { newValue in
            /// 빈 문자열인 경우 실행하지 않습니다.
            guard !newValue.isEmpty
            else { return }
            
            guard newValue.contains("로이")
                    || newValue.contains("루이")
                    || newValue.contains("마크")
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
            guard !gpt.response.isEmpty
            else { return }
            
            gpt.parsedText = commandGPT()
            
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
    func commandGPT() -> String {
        let parsedText = gpt.response.split(separator: "#")
        print(parsedText)
        
        guard parsedText.count > 0
        else { return "" }
        
        let command = parsedText[0]
        
        switch command {
        case "Navigate":
            guard parsedText.count > 1
            else {
                break
            }
            
            if parsedText[1].contains("장바구니") {
                navigationViewModel.isPresentedCartView = true
            }
            else if parsedText[1].contains("결제") {
                navigationViewModel.isPresentedPaymentView = true
            }
            else if parsedText[1].contains("가게") || parsedText[1].contains("햄버거") {
                navigationViewModel.isPresentedMarketView = true
            }
            
        case "Move":
            guard parsedText.count > 1
            else {
                break
            }
            if parsedText[1].contains("가게") {
                navigationViewModel.isPresentedCartView = true
            }
            else if parsedText[1].contains("결제") {
                navigationViewModel.isPresentedPaymentView = true
            }
            else if parsedText[1].contains("가게") || parsedText[1].contains("햄버거") {
                navigationViewModel.isPresentedMarketView = true
            }
        case "Order":
            navigationViewModel.isPresentedPaymentView = true
        case "Pay":
            navigationViewModel.isOrder = true
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
                guard let menu = menuViewModel.menuIDs["24780C19-EFDA-4458-ACAA-1A3BF30AD1B9"]
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
        default:
            print("unknown command")
        }
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
                                 messages: [.init(role: "user",
                                                  content: sttRecognizer.talkedText)])
        /// 텍스트를 보낸 뒤 flush 합니다.
        sttRecognizer.talkedText.removeAll()
        
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
            timer.invalidate()
            /// STT 서비스를 종료합니다.
            sttRecognizer.isActiveSTTService = false
            requestGPTService()
        }
    }
    
    
    func resetTimer() {
        self.sttTimer?.invalidate()
        self.startTimer()
    }
}

#Preview {
    AISection()
        .environmentObject(SpeechRecognizer())
        .environmentObject(ChatGPTViewModel())
        .environmentObject(TextToSpeech())
}
