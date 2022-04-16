//
//  UserManager.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 16.04.2022.
//

import Foundation

final class UserManager: ObservableObject {
    
    @Published var user = User()
    
    init() {}
    
    init(user: User) {
        self.user = user
    }
}
