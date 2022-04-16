//
//  AuthViewModel.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 11.04.2022.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isAnonymous: Bool = true
        
    
    static let shared = AuthViewModel()
    
    private init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
        anonymousCheck()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: error login: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
        }
        print("login")
    }
    
    // Регистрация анонимно
    
    func registerAnon() {
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print("DEBUG: error register: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            let data = ["image_url" : "",
                        "user_name" : "",
                        "uid" : user.uid]
            
            Firestore.firestore().collection("Users").document(user.uid).setData(data) { _ in
                print("Successfully uploaded user data...")
                self.userSession = user
                self.fetchUser()
            }
        }
    }
    //Устанавливает электронную почту и пароль для текущего пользователя
    
    func updateEmail(with email: String, completion: @escaping (Result<String, Error>) -> ()) {
        self.fetchUser()
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            
                if let error = error {
                    print("DEBUG: error update email: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
            }
            print(Firebase.ErrorUserInfoKey.RawValue.self)
        }
    }
    
    func updatePassword(with password: String, completion: @escaping (Result<String, Error>) -> ()) {
        self.fetchUser()
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            
                if let error = error {
                    print("DEBUG: error update email: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
            }
        }
    }
    
    func updateUserLogInData(with email: String, with password: String) {
        self.fetchUser()
        }
    
    // Сброс пароля пользователя
    
    func sendLinkForPasswordReset(with email: String, completion: @escaping (Result<String, Error>) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("DEBUG: error update email: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
        }
    }
    
    func anonymousCheck() {
        if let user = userSession {
            if user.email != nil {
                isAnonymous.toggle()
            }
        }
    }
    
//    func registerWithEmailLink(withEmail: String) {
//        let actionCodeSettings = ActionCodeSettings()
//        actionCodeSettings.handleCodeInApp = true
//
//        let user = Auth.auth().currentUser
//        actionCodeSettings.url = URL(string: "https://networktest.page.link/qbvQ/?email=%@\(user?.email ?? "ars352@yahoo.com")")
//        actionCodeSettings.dynamicLinkDomain = "https://networktest.page.link"
//        user?.sendEmailVerification(with: actionCodeSettings)
//    }
    
    func signout() {
        
        self.userSession = nil
        try? Auth.auth().signOut()
        print("signout")
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            print("DEBUG: user is: \(user)")
        }
        print("fetchUser")
    }
}
