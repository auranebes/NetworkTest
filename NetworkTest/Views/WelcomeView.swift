//
//  WelcomeView.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 12.04.2022.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            
            VStack {
                
                Button(action: {
                    viewModel.registerAnon()
                }, label: {
                    Text("Anonymous")
                        .font(.title)
                        .foregroundColor(viewModel.currentUser != nil ? .green : .red)
                        .background(RoundedRectangle(cornerRadius: 12).strokeBorder())
                })
                
                VStack{
                    TextFieldView(subtitle: "email", typeTextField: .login, text: $email)
                    TextFieldView(subtitle: "password", typeTextField: .simple, text: $password)
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        Text("Log In")
                    }
                }
                
                
            .navigationTitle("Welcome")
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
