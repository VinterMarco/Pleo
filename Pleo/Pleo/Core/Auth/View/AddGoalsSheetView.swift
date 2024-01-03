//
//  AddGoalsSheetView.swift
//  Pleo
//
//  Created by Vinter Marco on 03.01.2024.
//

import SwiftUI

struct AddGoalsSheetView: View {
    
    @State private var typeOfGoal = "New Goal"
    @State private var amount = 0.0
    @State private var targetAmount = 0.0
    @State private var lastDepositDate = Date.now
    @State private var lastDepositString =  "2024-01-05"
    @State private var selectedSavingPlan =  "Select a Saving"
    @State private var selectedSavingPlanID =  "id"
    @State private var goalName = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @StateObject private var goalsManager = SavingGoalsManager()
    
    @State  var goalsList  = ["a", "v", "c"]
    
    

    
    @State private var goals = ["New Goal", "Existing Goal"]
    var body: some View {
        Picker("New Or Existing Goal", selection: $typeOfGoal) {
            ForEach(goals, id:\.self) { goal in
                Text(goal)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 250)
        Group {
            if typeOfGoal == "New Goal" {
                VStack {
                    VStack(spacing : 13) {
                        Text("New Goal")
                            .bold()
                            .font(.system(size: 33))
                        
                        VStack(alignment: .leading) {
                            Text("Goal Name")
                                .font(.footnote)
                            TextField("Enter goal name", text: $goalName)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text("Initial Ammount")
                                .font(.footnote)
                            TextField("Initial Ammount", value: $amount, format: .currency(code: "RON"))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text("Target Ammount")
                                .font(.footnote)
                            TextField("Target Ammount", value: $targetAmount, format: .currency(code: "RON"))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        
                        Button {
                            print("title \(goalName)")
                            print("amount \(amount)")
                            print("targeAmount \(targetAmount)")
                            print("last deposit date \(lastDepositDate)")
                            print("user id \(viewModel.currentUser?.id ?? "unasigned to a user")")
                            let newGoal = SavingGoal(title: goalName, addedAmount: amount, targetAmount: targetAmount, lastDepositDate: Date.now, userId: viewModel.currentUser?.id ?? "unasigned to a user")
                            goalsManager.addSaveGoals(newGoal)
                            dismiss()
                        } label: {
                            Text("Add Goal")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }
                    }
                }
                
            } else if typeOfGoal == "Existing Goal" {
                VStack {
                    VStack(spacing : 13) {
                        Text("Existing Goal")
                            .bold()
                            .font(.system(size: 33))
                        
                        VStack(alignment: .leading) {
                            Text("Goal Name")
                                .font(.footnote)
                            TextField("Enter goal name", text: $goalName)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                                .disabled(true)
                            
                        }
                        ////////////////////////////////////////////
                        VStack(alignment: .leading) {
                            Text("Savings")
                                .font(.footnote)
                            HStack (spacing : 2) {
                                Text("Choose a saving")
                                
                                Spacer()
                                Picker("", selection: $selectedSavingPlan) {
                                    ForEach(goalsList, id : \.self) { save in
                                        Text(save)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 0.6)
                            )
                        }
                        ////////////////////////////////////////////

                        
                        
                        VStack(alignment: .leading) {
                            Text("Add Ammount")
                                .font(.footnote)
                            TextField("Initial Ammount", value: $amount, format: .currency(code: "RON"))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Last Deposit Date")
                                .font(.footnote)
                            TextField("Target Ammount", text: $lastDepositString)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                                .disabled(true)
                        }
                        
                        
                        
                        Button {
                            // more code to come
                        } label: {
                            Text("Add A Deposit")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.blue)
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddGoalsSheetView()
}
