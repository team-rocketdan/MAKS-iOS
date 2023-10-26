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
            throw FirebaseError.notFound
        }
        let (metadata, error) = await putData(data: imageData)
        
        guard error == nil
        else {
            throw FirebaseError.failToUpload
        }
        guard let url = metadata?.path
        else {
            throw FirebaseError.failToUpload
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
            throw fatalError("Data를 Image로 변환하지 못했습니다. 다시 시도하세요.")
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
    case notFound
    case failToUpload
    case unknown
}
