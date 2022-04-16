//
//  ContentView.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 08.04.2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    // Users
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var users: [User] = [User(image_url: "", user_name: "")]
    @State var errorMessage = ""
    @State var showError = false
    var userName: String {
        ["Anna","Ben","John","Mark","Arslan"].randomElement()!
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(users){user in
                    HStack(alignment: .top, spacing: 15){
                        AsyncImage(url: URL(string: user.image_url ?? "")){phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(15)
                            } else {
                                ProgressView()
                                    .frame(
                                            maxHeight: .infinity,
                                            alignment: .center)
                            }
                        }
                        VStack(alignment: .leading, spacing: 6){
                            Text(user.user_name ?? "")
                                .font(.title2.bold())
                            Text("some human")
                        }
                    }
                }
            }
            .navigationTitle(viewModel.isAnonymous ? "Anonymous" : (users.first?.user_name ?? ""))
            // Pull to refresh
            .refreshable {
                
                viewModel.fetchUser()
                NetworkManager.shared.fetchUserDataWithCH(user_name: userName) { result in
                    switch result {
                        
                    case .success(let user):
                        self.users[0] = user
                    case .failure(let error):
                        print(error)
                    }
                }
               // fetchDataWithCH()
              //  await fetchData(email: "ars@mail.ru", password: "qwertyu")
            }
            // Allert
            .alert(errorMessage, isPresented: $showError){
                Button("Ok", role: .cancel){
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.signout()
                    } label: {
                        Text("Exit")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack{
                        NavigationLink {
                            AuthView()
                        } label: {
                            Text("Register User")
                        }
                        
                        NavigationLink {
                            SupportMailView()
                        } label: {
                            Text("Написать в поддержку")
                        }
                    }

                }
            }
        }
          
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// User модель






//Error

enum DatabaseError: String, Error {
    case failed = "Failed To Fetch From Database"
}

enum AuthError: String, Error {
    case failedToLogin = "Failed to Login"
}

