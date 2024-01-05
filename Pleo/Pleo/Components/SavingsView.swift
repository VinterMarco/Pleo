//
//  SavingsView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI

struct SavingsView: View {
    
    @State var showAddGoalView : Bool = false
    @StateObject private var goalsManager = SavingGoalsManager()

    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Color.blue.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hello, Marco 🚀")
                            .fontDesign(.rounded)
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                            .bold()
                            
                        Text("Savings")
                            .foregroundStyle(.white)
                            .font(.title).fontWeight(.medium)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Create a new goal!")
                                .fontWidth(Font.Width.expanded)
                                .font(.system(size: 28))
                                .bold()
                            HStack {
                                Text("\(goalsManager.savingGoals.count) dreams in the making")
                                    .offset(y : -3)
                                    .font(.system(size: 22))
                                Button {
                                    showAddGoalView.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(18)
                                        .font(.system(size: geometry.size.width < 600 ? 24 : 40))
                                        .bold()
                                        .background(.blue)
                                        .clipShape(.circle)
                                        .foregroundColor(.white)
                                        .shadow(color: .blue, radius: 2)
                                        .offset(x : 7)
                                }
                                .sheet(isPresented: $showAddGoalView) {
                                    AddGoalsSheetView(goalsManager : goalsManager)
                                }
                            }
                        }
                        .padding(0)
                        .frame(width: geometry.size.width - 70)

                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 20) {
                                    SavingsListView(goalsManager: goalsManager)
                        }
                        
                        .frame(width: geometry.size.width - 32, height : 420)
                        
                    }
                    .onAppear {
                        goalsManager.getSaveGoals()
                        
                        print(goalsManager.savingGoals)
                    }
                    
                    
              
                    // end of main vstack
                    .shadow(color: .gray, radius: 5)
                    .padding(0)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 10)
                }
            }
            
            .navigationTitle("Savings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SavingsView()
}
