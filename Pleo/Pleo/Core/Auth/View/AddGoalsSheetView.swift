//
//  AddGoalsSheetView.swift
//  Pleo
//
//  Created by Vinter Marco on 03.01.2024.
//

import SwiftUI

struct AddGoalsSheetView: View {
    
    func printer(a: String) {
        print(a)
    }
    
    @EnvironmentObject var viewModel : AuthViewModel
//    @StateObject private var goalsManager = SavingGoalsManager()
    @ObservedObject var goalsManager: SavingGoalsManager

    
    
    
    @State private var typeOfGoal = "New Goal"
    @State private var goals = ["New Goal", "Existing Goal"]
    @State private var amount = 0.0
    @State private var targetAmount = 0.0
    @State private var lastDepositDate = Date.now
    @State private var lastDepositString =  "2024-01-05"
    @State var goalsList  = ["a","b","c"]
    @State  var selectedSavingPlan:String = ""
    
    
    @State private var selectedSavingPlanID =  "id"
    @State private var goalName = ""
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
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
    }
}

//#Preview {
//    AddGoalsSheetView()
//}
