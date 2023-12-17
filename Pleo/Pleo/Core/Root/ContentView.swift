//
//  ContentView.swift
//  Pleo
//
//  Created by Vinter Marco on 16.12.2023.
//

import SwiftUI

// PLEO = (I sail, travel by sea, voyage.)

@MainActor
struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        
        Group {
            if viewModel.userSession != nil {
                Text("Hello, User!")
//                HStack {
//                    if let user = viewModel.currentUser {
//                        Text("user name is : \(user.fullName)")
//                    } else {
//                        Text("error")
//                    }
//                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
