//
//  AuthManager.swift
//  Instagram
//
//  Created by Andrei Mosneag on 07.06.2022.
//
import FirebaseAuth
import FirebaseDatabase
import UIKit

public class AuthManager {
    
    static let shared = AuthManager()
    
    //MARK: -Public
    
    public func registerNewUser(username: String, email: String, password: String, complition: @escaping (Bool) -> Void) {
        
        /*
        -Check if username id available
        -Check if email is available
         -Create account
         -Insert account to database
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else  {
                        // Firebase could not create account
                        complition(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(whith: email, username: username) { insert in
                        if insert {
                            complition(true)
                            
                        }else{
                            complition(false)
                            return
                        }
                    }
                }
            }
            else {
                complition(false)
            }
        }
        
    }
    public func loginUser(username: String?, email: String?, password: String, comletion: @escaping (Bool) -> Void ){
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    comletion(false)
                    return
                }
                comletion(true)
            }
        }
        else if let username = username {
            // user log in
            print(username)
        }
    }
    //
    public func logOut (completion:(Bool) -> Void ) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print("Is not sing out\(error)")
            completion(false)
            return
        }
    }
    
    
    
}
