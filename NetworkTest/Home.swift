//
//  Home.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 12.04.2022.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession == nil {
            WelcomeView()
        } else {
            ContentView()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
