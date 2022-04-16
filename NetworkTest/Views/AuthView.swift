//
//  AuthView.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 12.04.2022.
//

import SwiftUI

struct AuthView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var errorText = ""
    @State var errorOccured = false
    
    var body: some View {
        VStack{
            TextFieldView(subtitle: "email", typeTextField: .login, text: $email)
            TextFieldView(subtitle: "password", typeTextField: .simple, text: $password)
            // Update auth data button
            Button {
                // E-mail
                viewModel.updateEmail(with: email) { error in
                    switch error {
                        
                    case .success(_):
                        do {}
                    case .failure(let error):
                        
                        self.errorText = error.localizedDescription
                        self.errorOccured = true
                        
                    }
                }
                // Password
                viewModel.updatePassword(with: password) { error in
                    switch error {
                        
                    case .success(_):
                        do {}
                    case .failure(let error):
                        self.errorText = error.localizedDescription
                        self.errorOccured = true
                    }
                }
                
                
            } label: {
                Text("Set Data")
            }.alert(errorText, isPresented: $errorOccured) {
                Button("Ok", role: .cancel){
                    self.errorOccured = false
                }
            }
            
            // Reset Password Button
            Button {
                viewModel.sendLinkForPasswordReset(with: email) { error in
                    switch error {
                        
                    case .success(_):
                        do {}
                    case .failure(let error):
                        self.errorText = error.localizedDescription
                        self.errorOccured = true
                    }
                }
            } label: {
                Text("Reset password")
            }.alert(errorText, isPresented: $errorOccured) {
                Button("Ok", role: .cancel){
                    self.errorOccured = false
                }
            }
        }.onChange(of: viewModel.isAnonymous) { newValue in
            if !viewModel.isAnonymous {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
