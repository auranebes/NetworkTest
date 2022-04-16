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
                .onAppear {
                    // This suppresses constraint warnings
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    print(UIDevice.current.systemVersion)
                    print(UIDevice.current.modelName)
                    print(Bundle.main.displayName)
                    print(Bundle.main.appVersion)
                    print(Bundle.main.appBuild)
                }
        }
    }
}
