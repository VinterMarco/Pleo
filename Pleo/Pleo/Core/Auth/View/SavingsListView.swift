//
//  SavingsListView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI



struct SavingsListVasselView : View {
    
    var savings : SavingGoal
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
                    Text("\(savings.addedAmount.formatted(.currency(code: "RON")))")
                        .foregroundStyle(Color(
                            red: 1.0 - 255 / 255.0,
                            green: 1.0 - 190 / 255.0,
                            blue: 1.0 - 152 / 255.0
                        ))
                        .font(.title2)
                        .bold()
                    HStack(spacing : 4) {
                        Text(" \(savings.title)")
                            .foregroundStyle(.black)
                        Text("~ Last Deposit : \(formattedDate(date: savings.lastDepositDate))")
                        
                    }
                    .font(.system(size: 12))
                    .bold()
                    .foregroundStyle(.gray)
                    .offset(x : -3)
                    VStack (alignment : .leading, spacing : -11){
                        if savings.targetAmount >= savings.addedAmount {
                            Text("Left to save : \((savings.targetAmount - savings.addedAmount).formatted(.currency(code: "RON")))")
                                .font(.system(size: 10))
                                .foregroundColor(.primary)
                        } else {
                            Text("Amount Saved : \((savings.addedAmount).formatted(.number)) / \(savings.targetAmount.formatted(.currency(code: "RON")))")
                                .font(.system(size: 10))
                                .foregroundColor(.primary)
                        }
                        ProgressView("", value: savings.addedAmount, total: savings.targetAmount)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(.mint)
                            .opacity(savings.targetAmount >= savings.addedAmount ? 1 : 0)
                        
                        HStack {
                            Text("Saving Plan Completed")
                                .foregroundStyle(.black)
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                        .offset(y : 7)
                        .opacity(savings.targetAmount >= savings.addedAmount ? 0 : 1)
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
                    NavigationLink  {
                        SavingsDepositsView(savings: expense)
                    } label: {
                        VStack {
                            SavingsListVasselView(savings : expense, index : index)
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
