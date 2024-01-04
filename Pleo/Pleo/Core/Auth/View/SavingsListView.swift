//
//  SavingsListView.swift
//  Pleo
//
//  Created by Vinter Marco on 02.01.2024.
//

import SwiftUI



struct SavingsListVasselView : View {
    
    @StateObject private var goalsManager = SavingGoalsManager()
    @State var amount = 0.0
    @State var title = ""
    @State var date = Date.now
    @State var target = 100.0
    
    
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
                    Text("\(amount.formatted(.currency(code: "RON")))")
                        .font(.title2)
                        .bold()
                    Text(" \(title) ~ Last Deposit : \(formattedDate(date: date))")
                        .font(.system(size: 12))
                        .bold()
                        .foregroundStyle(.gray)
                        .offset(x : -3)
                    VStack (alignment : .leading, spacing : -11){
                        Text("Left to save : \((target - amount).formatted(.currency(code: "RON")))")
                            .font(.system(size: 10))
                            .foregroundColor(.primary)
                        
                        ProgressView("", value: amount, total: target)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(.mint)
                        
                        
                        
                    }
                }
                
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        
    }
}


struct SavingsListView: View {
    @StateObject private var goalsManager = SavingGoalsManager()
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(goalsManager.savingGoals, id: \.id) { expense in
                    NavigationStack {
                        NavigationLink {
                            SavingsDepositsView(savings: expense)
                        } label: {
                            VStack {
                                SavingsListVasselView(amount: expense.addedAmount, title: expense.title, date: expense.lastDepositDate, target: expense.targetAmount)
                                
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .onAppear {
//                    goalsManager.getSaveGoals()
//                    print("ON APPEAR IS ACTIVATED")
//                    print(goalsManager.savingGoals)
//                    print(goalsManager.savingGoals)
                }
            }
        }
    }
}

#Preview {
    SavingsListView()
}
