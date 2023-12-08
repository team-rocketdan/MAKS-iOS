//
//  ChatGPTViewModel.swift
//  MAKS
//
//  Created by sole on 2023/10/05.
//

import SwiftUI
import Alamofire
import SwiftyJSON

class ChatGPTViewModel: ObservableObject {
    let url = Bundle.main.infoDictionary?["GPTServerURL"] as? String ?? ""
    let apiKey = Bundle.main.infoDictionary?["GPTAPIKey"] as? String ?? ""

    @Published var response: String = ""
    @Published var parsedText: String = ""
    
    func post(req: GPTRequest) async throws -> GPTResponse {
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let encodedData = try jsonEncoder.encode(req)
        
        var request = URLRequest(url: URL(string: url) ?? .homeDirectory)
        request.method = .post
        
        request.httpBody = encodedData
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)",
                         forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        let serializedData = AF.request(request).serializingData()
        let response = await serializedData.response
    
        switch response.result {
        case .success(let responseData):
            let res = try decodeJSON(data: responseData, type: GPTResponse.self)
            DispatchQueue.main.async {
                self.response = res.choices[0].message.content
                print(res.choices[0].message)
            }
            return res
        case .failure(let error):
            /// response body가 empty인 경우 예외처리입니다.
            let statusCode = response.response?.statusCode
            guard statusCode != 200,
                  statusCode != 204,
                  statusCode != 205
            else {
                return .defaultModel
            }
            throw error
        }
    }
    
}
