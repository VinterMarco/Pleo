//
//  AuthViewModel.swift
//  Pleo
//
//  Created by Vinter Marco on 17.12.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        // for keeping the user sing in
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email : String, password : String) async throws {
        let result = try await Auth.auth().signIn(withEmail : email, password: password)
        self.userSession = result.user
        await fetchUser()
        print("User signed in")
    }
    
    
    
    
    func createUser(withEmail email : String, password : String, fullname : String) async throws {
        print("User created")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, emai: email)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
            await fetchUser()
        } catch {
            print("DEBUG : Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return
        }
        self.currentUser  = try? snapshot.data(as : User.self)
        
        print("Current user is \(String(describing: self.currentUser))")
    }
    
}
