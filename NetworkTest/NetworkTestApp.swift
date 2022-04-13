//
//  NetworkTestApp.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 08.04.2022.
//

import SwiftUI
import Firebase

@main
struct NetworkTestApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
