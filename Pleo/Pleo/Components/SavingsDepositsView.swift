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
    @EnvironmentObject var savingsManager: SavingGoalsManager
    @EnvironmentObject var viewModel : AuthViewModel
    
    



    var body: some View {

        
        VStack {
            VStack(spacing : 22) {
                Text(savings.title)
                    .bold()
                    .font(.system(size: 33))
                
                VStack(alignment: .leading) {
                    Text("Add Deposit")
                        .font(.footnote)
                    TextField("Ammount", value: $addAmmount, format: .currency(code: "RON"))
                        .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.6)
                        )
                }
                
                
                VStack(alignment: .leading) {
                    Text("Current Ammount")
                        .font(.footnote)
                    Text("\(savings.addedAmount.formatted(.currency(code: "RON")))")
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
                    Text("\(savings.targetAmount.formatted(.currency(code: "RON")))")
                        .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.6)
                        )
                }
                
                
                
                Button {
                    savingsManager.updateSaveGoal(goalId: savings.documenttName ?? "", newAddedAmount: addAmmount + savings.addedAmount)
                    addAmmount = 0
                    
                } label: {
                    Text("Add Deposit")
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
        ///
        
    }
}

#Preview {
    SavingsDepositsView(savings: SavingGoal.MOCK_Save_Goal, addAmmount: 50.0)
}
