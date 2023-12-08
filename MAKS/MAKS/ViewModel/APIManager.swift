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
    /// 데이터를 db에 등록할 때 사용하는 메서드입니다.
    func post(_ url: String,
              data: T) async throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let encodedData = try jsonEncoder.encode(data)
        
        var request = URLRequest(url: URL(string: url) ?? .homeDirectory)
        request.method = .post
        
        request.httpBody = encodedData
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        let serializedData = AF.request(request).serializingData()
        let response = await serializedData.response
        
        switch response.result {
        case .success(let responseData):
            return responseData
        case .failure(let error):
            /// response body가 empty인 경우 예외처리입니다. 
            let statusCode = response.response?.statusCode
            guard statusCode != 200,
                  statusCode != 204,
                  statusCode != 205
            else {
                return Data()
            }
            throw error
        }
    }
    
    //MARK: - delete
    /// 데이터를 db에서 삭제할 때 사용하는 메서드입니다.
    func delete() async throws {
        
    }
    
    //MARK: - update
    /// 데이터를 db에서 수정할 때 사용하는 메서드입니다. 
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
    func post(_ url: String, data: T) async throws -> Data
    func delete() async throws
    func update() async throws
}
