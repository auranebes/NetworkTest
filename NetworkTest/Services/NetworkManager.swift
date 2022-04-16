//
//  NetworkManager.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 11.04.2022.
//

import Foundation
import Firebase

class NetworkManager {
    static let shared = NetworkManager()
    
    
    private init() {}
    
    func fetchUserDataWithCH(user_name: String, completion: @escaping (Result<User, DatabaseError>) -> Void){
        
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("Users").document(uid).updateData(["image_url" : "",
                                                                            "uid" : uid,
                                                                            "user_name" : user_name]) { error in
                if let error = error {
                print("DEBUG: uploadUserData error: \(error.localizedDescription)")
                completion(.failure(.failed))
                return
            }
            
            Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, error in
                if error != nil {
                    completion(.failure(.failed))
                    return
                }
                
                guard let user = try? snapshot?.data(as: User.self) else { return }
                completion(.success(user))
                print("DEBUG: user is: \(user)")
            }
        }
    }
}
