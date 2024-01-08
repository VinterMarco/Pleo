//
//  SavingsView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI

struct SavingsView: View {
    
    @State var showAddGoalView : Bool = false
    @EnvironmentObject var savingsManager : SavingGoalsManager
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    func formattedName(name : String) -> String {
            let components = name.components(separatedBy: " ")
            if components.count >= 2 {
                let firstName = components[0]
                let lastName = components[1]
                return firstName
                
            } else {
                return "friend"
            }
    }
    
    
//    Color(red: 255 / 255.0, green: 190 / 255.0, blue: 152 / 255.0)
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Color(red: 255 / 255.0, green: 190 / 255.0, blue: 152 / 255.0).ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hello, \(formattedName(name: viewModel.currentUser?.fullName ?? "friend")) 🚀")
                            .fontDesign(.rounded)
                            .font(.system(size: 23))
                            .foregroundColor(.white)
                            .bold()
                            .shadow(color: .clear,radius: 0)
                            .animation(.bouncy, value: formattedName(name: viewModel.currentUser?.fullName ?? "friend"))
                        
                        Text("Savings")
                            .foregroundStyle(.white)
                            .font(.title).fontWeight(.medium)
                            .shadow(color: .clear,radius: 0)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Create a new goal!")
                                .fontWidth(Font.Width.expanded)
                                .font(.system(size: 28))
                                .bold()
                            HStack {
                                Text("\(savingsManager.savingGoals.count) dreams in the making")
                                    .offset(y : -3)
                                    .font(.system(size: 22))
                                Button {
                                    showAddGoalView.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(18)
                                        .font(.system(size: geometry.size.width < 600 ? 24 : 40))
                                        .bold()
                                        .background(Color(
                                            red: 1.0 - 255 / 255.0,
                                            green: 1.0 - 190 / 255.0,
                                            blue: 1.0 - 152 / 255.0
                                        ))
                                        .clipShape(.circle)
                                        .foregroundColor(.white)
                                        .shadow(color: Color(
                                            red: 1.0 - 255 / 255.0,
                                            green: 1.0 - 190 / 255.0,
                                            blue: 1.0 - 152 / 255.0
                                        ), radius: 2)
                                        .offset(x : 7)
                                }
                                .sheet(isPresented: $showAddGoalView) {
                                    AddGoalsSheetView()
                                        .environmentObject(savingsManager) // This makes myObject available to the entire view hierarchy
                                    
                                }
                            }
                        }
                        .padding(0)
                        .frame(width: geometry.size.width - 70)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            SavingsListView()
                                .environmentObject(savingsManager) // This makes myObject available to the entire view hierarchy
                        }
                        .frame(width: geometry.size.width - 32, height : 420)
                        
                    }
                    .onAppear {
                        savingsManager.getSaveGoals()
                        print(savingsManager.savingGoals)
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
