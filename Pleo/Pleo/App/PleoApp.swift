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

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
