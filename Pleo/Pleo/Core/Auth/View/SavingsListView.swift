//
//  SavingsListView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI



struct SavingsListVasselView : View {
    var body: some View {
        Text("MORE CODE TO COME")
    }
}


struct SavingsListView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Saving 1")
                Text("Saving 2")
                Text("Saving 3")
                Text("Saving 4")
                Text("Saving 5")
                Text("Saving 6")
                Text("Saving 7")
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    SavingsListView()
}
