//
//  CustomTabView.swift
//  Pleo
//
//  Created by Vinter Marco on 18.12.2023.
//

import SwiftUI


struct CustomTabView: View {
    
    
    var body: some View {
        TabView {
            Text("Savings")
                .tabItem {
                    Label("Savings", systemImage: "dollarsign.circle.fill")
                }
            ExpensesView()
                .tabItem {
                    Label("Add Expenses", systemImage: "plus.circle.fill")
                }
            Text("Analytics")
                .tabItem {
                    Label("Analytics", systemImage: "chart.bar.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    CustomTabView()
}
