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
        Text("current amount\(savings.addedAmount)")
        Text("targer amount\(savings.targetAmount)")
        Text(savings.documenttName ?? "")
        
        TextField("Ammount", value: $addAmmount, format: .currency(code: "RON"))

        Button {
            let sendedAmount = savings.addedAmount + addAmmount
            goalsManager.updateSaveGoal(
            goalId: savings.documenttName ?? "",
            newAddedAmount: sendedAmount
            )
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
