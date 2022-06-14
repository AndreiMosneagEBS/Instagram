//
//  DataBase.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared  = DatabaseManager()
    private let database = Database.database(url: "https://instagram-7ffdc-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    public func canCreateNewUser(with email:String, username:String, completion: (Bool) -> Void) {
         completion(true)
    }
    
    deinit {
        print(#function)
    }
    
    public func insertNewUser( whith email:String, username: String, completion: @escaping (Bool) -> Void) {
       database.child(email.savaDataBasekey()).setValue(["username":username]) { error, _ in
            if error == nil {
                // succesc
                completion(true)
                return
            }else{
                //faled
                completion(false)
                return
            }
        }
        
    }
//MARK: - Private
    
 }

