//
//  STTTestView.swift
//  MAKS
//
//  Created by sole on 2023/09/30.
//

import SwiftUI
import Speech
import AVFoundation

struct STTTestView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var isRecording: Bool = false
    @State var text: String = ""
    var body: some View {
        VStack(spacing: 5) {
            Text(text)
            
            Text(isRecording ? "녹음 중" : "녹음 중지")
            
            
            Spacer()
            
            Button {
                if !isRecording {
                    speechRecognizer.startTranscribing()
                    isRecording = true
                } else {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                }
            } label: {
                Text("말하기")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                text = speechRecognizer.transcript
            } label: {
                Text("출력")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                speechRecognizer.resetTranscript()
            } label: {
                Text("reset")
            }
            .buttonStyle(.borderedProminent)

        }

    }
}


