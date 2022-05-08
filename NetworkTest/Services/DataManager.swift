//
//  DataManager.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 16.04.2022.
//

import SwiftUI
import Firebase
import FirebaseStorage

class DataManager {
    
    static let shared = DataManager()
    let urlStringPDF = "gs://networktest-56543.appspot.com/sample.pdf"
    
    @AppStorage("User") private var userData: Data?
    
    private init() {}
    
    func saveUser(user: User) {
        userData = try? JSONEncoder().encode(user)
    }
    
    func loadUser() -> User {
        guard let user = try? JSONDecoder().decode(User.self, from: userData ?? Data()) else { return User() }
        return user
    }
    
    func clear(userManager: UserManager) {
        userManager.user.user_name = ""
        userData = nil
    }
    
    func getURLFromFirestore(path: String, success:@escaping (_ docURL:URL)->(),failure:@escaping (_ error:Error)->()){
        
        let storage = Storage.storage().reference(forURL: path)
         storage.downloadURL { (url, error) in
             if let _error = error{
                 print(_error.localizedDescription)
                 failure(_error)
             } else {
                 if let docURL = url {
                     success(docURL)
                 }
             }
         }
    }

    func urlForDocPath(path: String, success: @escaping (_ docURL:URL?)->(), failure: @escaping (_ error:Error)->()) {
        getURLFromFirestore(path: path,  success: { (docURL) in
            success(docURL)
        }) { (error) in
            failure(error)
        }
    }
}
