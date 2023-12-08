//
//  TextToSpeech.swift
//  MAKS
//
//  Created by sole on 2023/10/13.
//

import Foundation
import AVFoundation

class TextToSpeech: ObservableObject {
    private let synthesizer: AVSpeechSynthesizer = .init()
    
    let delegate: TextToSpeechDelegate = .init()
    
    
    init() {
        self.synthesizer.delegate = self.delegate
    }
    
    //MARK: - startTTS
    
    func startTTS(message: String) {
        let utter = AVSpeechUtterance(string: message)
        utter.voice = AVSpeechSynthesisVoice(language: Locale.preferredLanguages.first)
        
        self.synthesizer.speak(utter)
    }
}

class TextToSpeechDelegate: NSObject,
                            AVSpeechSynthesizerDelegate,
                            ObservableObject {
    
    @Published var isActive: Bool = false
    
    //FIXME: 자동으로 request 보낼 시 isActive 변경이 제대로 적용되지 않는 현상
    /// 읽는 것이 종료되었을 때 실행되는 메서드
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        print("end tts")
        DispatchQueue.main.async {
            self.isActive = false
        }
    }
    
    /// 읽는 것이 시작될 때 실행되는 메서드
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("start tts")
        DispatchQueue.main.async {
            self.isActive = true
        }
    }
}
