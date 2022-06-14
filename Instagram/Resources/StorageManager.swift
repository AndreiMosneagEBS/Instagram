//
//  StorageManager.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//

import FirebaseStorage
import UIKit

public class StorageManager {
     
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
   public enum IGStorageManagerError: Error {
        case faildToDowloand
    }
    
    
    //MARK: - Public
    
    public func uploadUserPhotoPost(model: UserPost, completion:(Result<URL, Error>)-> Void) {
        
    }
    
    public func dowloandImage(with refereance: String, complition:@ escaping (Result<URL, IGStorageManagerError>)-> Void){
        bucket.child(refereance).downloadURL { url, error in
            guard let url = url, error == nil else {
                complition(.failure(.faildToDowloand))
                return
            }
            complition(.success(url))
        }
    }
}
    
    
