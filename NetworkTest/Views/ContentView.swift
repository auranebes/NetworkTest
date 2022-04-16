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
                        AsyncImage(url: URL(string: user.image_url)){phase in
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
                            Text(user.user_name)
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
                    NavigationLink {
                        AuthView()
                    } label: {
                        Text("Register User")
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

    

extension ContentView{
    
    // Async/Await method
    
    func fetchData(email: String, password: String)async{
        do{
            // Auth...
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let userID = authResult.user.uid
            // Getting User Data
            let document = try await Firestore.firestore().collection("Users").document(userID).getDocument().data(as: User.self)
            guard let userData = try? document else {
                throw DatabaseError.failed
            }
            
            // Добавляем Data
            self.users = [userData]
        }
        catch{
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }

    //Fetching Data Using Completion Handler
    
// sign in and return UID
func authUserWithCH(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> ()) {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if let _ = error{
            completion(.failure(.failedToLogin))
            return
        }
        
        guard let user = result else{
            completion(.failure(.failedToLogin))
            return
        }
        
        completion(.success(user.user.uid))
        print("auth success")
    }
}

// This will return User data from UID

func fetchUserDataWithCH(userId: String, completion: @escaping (Result<[User], DatabaseError>) -> ()){
    Firestore.firestore().collection("Users").document(userId).getDocument { snapshot, error in
        if let _ = error {
            completion(.failure(.failed))
            return
        }
        guard let userData = try? snapshot?.data(as: User.self) else {
            completion(.failure(.failed))
            print("Model incorrect")
            return
        }
        
        completion(.success([userData]))
       
    }
}

// This will use those to get and set data

func fetchDataWithCH() {
    authUserWithCH(email: "ars@mail.ru", password: "qwertyu") { result in
        switch result{
            
        case .success(let userId):
            fetchUserDataWithCH(userId: userId){ result in
                switch result{
                    
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    errorMessage = error.rawValue
                    showError.toggle()
                }
            }
        case .failure(let error):
            errorMessage = error.rawValue
            showError.toggle()
            }
        }
    }
}
