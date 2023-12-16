//
//  ContentView.swift
//  Pleo
//
//  Created by Vinter Marco on 16.12.2023.
//

import SwiftUI

// PLEO = (I sail, travel by sea, voyage.)

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome To Pleo")
                .font(.title)
                .bold()
            HStack {
                Text("Maybe the BEST")
                Text("AI-Powered")
                    .fontDesign(.monospaced)
                    .foregroundStyle(.blue)
                Text("finance advicer.")
            }
        }
    }
}

#Preview {
    ContentView()
}
