//
//  SavingsListView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI



struct SavingsListVasselView : View {
    
    @EnvironmentObject var savingsManager : SavingGoalsManager
    var index  = 0
 
    func formattedDate(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    var body: some View {
        VStack  {
            HStack (spacing : 20) {
                Image(systemName: "dollarsign.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
                VStack (alignment : .leading, spacing: 4) {
                    Text("\(savingsManager.savingGoals[index].addedAmount.formatted(.currency(code: "RON")))")
                        .font(.title2)
                        .bold()
                    HStack(spacing : 4) {
                        Text(" \(savingsManager.savingGoals[index].title)")
                            .foregroundStyle(.black)
                        Text("~ Last Deposit : \(formattedDate(date: savingsManager.savingGoals[index].lastDepositDate))")

                    }

                        .font(.system(size: 12))
                        .bold()
                        .foregroundStyle(.gray)
                        .offset(x : -3)
                    VStack (alignment : .leading, spacing : -11){
                        Text("Left to save : \((savingsManager.savingGoals[index].targetAmount - savingsManager.savingGoals[index].addedAmount).formatted(.currency(code: "RON")))")
                            .font(.system(size: 10))
                            .foregroundColor(.primary)
                        
                        ProgressView("", value: savingsManager.savingGoals[index].addedAmount, total: savingsManager.savingGoals[index].targetAmount)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(.mint)
                    }
                }
                
            }
        }
        .onAppear {
            savingsManager.getSaveGoals()
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        
    }
}


struct SavingsListView: View {

    @EnvironmentObject var savingsManager : SavingGoalsManager

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(Array(savingsManager.savingGoals.enumerated()), id: \.element.id) { (index, expense)    in                 NavigationStack {
                        NavigationLink {
                            SavingsDepositsView(savings: expense)
                        } label: {
                            VStack {
                                SavingsListVasselView(index : index)
                                
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .onAppear {
                }
            }
        }
    }
}

#Preview {
    SavingsListView()
}
