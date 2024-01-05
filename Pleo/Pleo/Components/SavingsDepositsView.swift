//
//  SavingsDepositsView.swift
//  Pleo
//
//  Created by Vinter Marco on 04.01.2024.
//

import SwiftUI

struct SavingsDepositsView: View {
    var savings : SavingGoal
    @State var addAmmount : Double = 0.0
    @StateObject private var goalsManager = SavingGoalsManager()

    var body: some View {
        Text(savings.title)
            .font(.title).bold()
        HStack (spacing : 20) {
            Text("\(savings.addedAmount.formatted(.currency(code: "RON")))")
            Text("Current")
        }
        HStack (spacing : 20) {
            Text("\(savings.targetAmount.formatted(.currency(code: "RON")))")
            Text("Target")
        }

        TextField("Ammount", value: $addAmmount, format: .currency(code: "RON"))
            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 0.6)
            )
        

        Button {
            let newSaveGoal = SavingGoal(title: savings.title, addedAmount: savings.addedAmount + addAmmount, targetAmount: savings.targetAmount, lastDepositDate: Date.now, userId: savings.userId)
            goalsManager.addSaveGoals(newSaveGoal)
            goalsManager.deleteSaveGoal(withId: savings.documenttName ?? "")
        } label: {
            Text("Add Deposit")
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    SavingsDepositsView(savings: SavingGoal.MOCK_Save_Goal, addAmmount: 50.0)
}
