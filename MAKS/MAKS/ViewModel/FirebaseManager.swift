//
//  FirebaseManager.swift
//  MAKS
//
//  Created by sole on 2023/10/19.
//

import SwiftUI
import UIKit
import FirebaseStorage

struct FirebaseManager {
    let storage = Storage.storage()
    let storageReference = Storage.storage().reference()
    
    
    func uploadImage(image: UIImage) async throws -> String {
        guard let imageData = image.pngData()
        else {
            throw FirebaseError.notFound("파일을 찾을 수 없습니다.")
        }
        let (metadata, error) = await putData(data: imageData)
        
        guard error == nil
        else {
            throw FirebaseError.failToUpload("이미지 업로드에 실패했습니다.")
        }
        guard let url = metadata?.path
        else {
            throw FirebaseError.failToUpload("이미지 업로드에 실패했습니다.")
        }
        
        return url
    }
    
    func downloadImage(path: String) async throws -> UIImage {
        let (data, error) = await getData(path: path)
        if let error {
            throw error
        }
        guard let data,
                let image = UIImage(data: data)
        else {
            throw FirebaseError.cannotConvert("이미지 변환에 실패했습니다!")
        }
        
        return image
    }
}

extension FirebaseManager {
    func putData(data: Data) async -> (StorageMetadata?, Error?) {
        return await withCheckedContinuation { continuation in
            storageReference.child("images").child(UUID().uuidString).putData(data, metadata: nil) { (metadata, error) in
                continuation.resume(returning: (metadata, error))
            }
        }
    }
    
    func getData(path: String,
                 maxSize: Int64 = 1024 * 1024 * 1024) async -> (Data?, Error?) {
        return await withCheckedContinuation { continuation in
            storageReference.child(path).getData(maxSize: maxSize) { data, error in
                continuation.resume(returning: (data, error))
            }
        }
    }
}

enum FirebaseError: Error {
    case notFound(_ message: String?)
    case failToUpload(_ message: String?)
    case unknown(_ message: String?)
    case cannotConvert(_ message: String?)
}
