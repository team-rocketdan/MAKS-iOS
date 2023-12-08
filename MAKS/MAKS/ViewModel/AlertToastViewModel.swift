//
//  AlertToastViewModel.swift
//  MAKS
//
//  Created by sole on 2023/10/19.
//

import SwiftUI
import AlertToast

class AlertToastViewModel: ObservableObject {
    @Published var isProcessing: Bool = false
    
    @Published var isError: Bool = false
    
    @Published var isComplete: Bool = false
}
