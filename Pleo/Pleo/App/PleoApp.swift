//
//  PleoApp.swift
//  Pleo
//
//  Created by Vinter Marco on 16.12.2023.
//

import SwiftUI
import Firebase



@main
struct PleoApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var savingsManager = SavingGoalsManager()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color(
                    red: 1.0 - 255 / 255.0,
                    green: 1.0 - 190 / 255.0,
                    blue: 1.0 - 152 / 255.0
                ))
                .environmentObject(viewModel)
                .environmentObject(savingsManager)
        }
    }
}
