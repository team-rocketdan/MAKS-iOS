//
//  GPTResponse.swift
//  MAKS
//
//  Created by sole on 2023/10/05.
//

import Foundation

struct GPTResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let usage: Tokens
    let choices: [Choice]
    
    static let defaultModel: GPTResponse = .init(id: "unknown",
                                                 object: "",
                                                 created: 0,
                                                 model: "",
                                                 usage: .init(prompt: 0,
                                                              completion: 0,
                                                              total: 0),
                                                 choices: [])
}


struct Choice: Codable {
    let index: Int
    let message: Message
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index = "index"
        case message = "message"
        case finishReason = "finish_reason"
    }
}

struct Tokens: Codable {
    let prompt: Int
    let completion: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case prompt = "prompt_tokens"
        case completion = "completion_tokens"
        case total = "total_tokens"
    }
}
