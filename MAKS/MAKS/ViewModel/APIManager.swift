//
//  APIManager.swift
//  MAKS
//
//  Created by sole on 2023/09/27.
//

import Foundation
import Alamofire
import SwiftyJSON

/// API 통신 시 사용하는 구조체입니다. 
struct APIManager<T: Codable>: APIRequest {
    //MARK: - get
    /// 데이터 하나만 받아올 때 사용하는 메서드입니다.
    func get(_ url: String) async throws -> T {
        let serializingData = AF.request(url,
                   method: .get,
                                         parameters: nil).serializingData()
        let response = await serializingData.response
        switch response.result {
        case .success(let data):
            let decodedData = try decodeJSON(data: data, type: T.self)
            return decodedData
        case .failure(let error):
            throw error
        }
    }
    
    //MARK: - fetch
    /// 경로 내 모든 데이터(배열)를 불러올 때 사용하는 메서드입니다.
    func fetch(_ url: String) async throws -> [T] {
        let serializingData = AF.request(url,
                   method: .get,
                                         parameters: nil).serializingData()
        let response = await serializingData.response
        switch response.result {
        case .success(let data):
            let decodedData = try decodeJSON(data: data, type: [T].self)
            return decodedData
        case .failure(let error):
            throw error
        }
    }
    
    //MARK: - post
    
    func post(_ url: String,
              data: T) async throws -> Result<Data, Error> {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let encodedData = try jsonEncoder.encode(data)
        
        var request = URLRequest(url: URL(string: url) ?? .applicationDirectory)
        request.method = .post
        request.httpBody = encodedData
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        let serializedData = AF.request(request).serializingData()
        let response = await serializedData.response
        switch response.result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    //MARK: - delete
    
    func delete() async throws {
        
    }
    
    //MARK: - update
    
    func update() async throws {
        
    }
}

//MARK: - decodeJSON
/// JSON을 parsing하는 메서드입니다.
func decodeJSON<T: Codable>(data: Data, type: T.Type) throws -> T {
    do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    } catch {
        print("\(error.localizedDescription)")
        throw error
    }
}


//MARK: - APIRequest

protocol APIRequest {
    associatedtype T
    func get(_ url: String) async throws -> T
    func fetch(_ url: String) async throws -> [T]
    func post(_ url: String, data: T) async throws -> Result<Data, Error>
    func delete() async throws
    func update() async throws
}
