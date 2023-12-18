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
                CustomTabView()
            }
            else {
                LoginView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
