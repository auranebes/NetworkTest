//
//  DataManager.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 16.04.2022.
//

import SwiftUI

class DataManager {
    
    static let shared = DataManager()
    
    
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
}
