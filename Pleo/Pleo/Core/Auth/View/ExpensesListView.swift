//
//  ExpensesListView.swift
//  Pleo
//
//  Created by Vinter Marco on 22.12.2023.
//

import SwiftUI



struct ExpensesListVassel : View {
    @State  var title : String
    @State  var date : Date
    @State  var amount : Double
    @State var category : String
    var color : Color {
        if category == "Other" {
            return Color.pink
        }
        if category == "Car" {
            return Color.purple
        }
     
        if category == "Clothes" {
            return Color.yellow
        }
     
        if category == "Utilities" {
            return Color.blue
        }
     
        if category == "Take Out" {
            return Color.green
        }
     
        
        return Color.clear
    }
    
    
    var body: some View {
                VStack {
                    HStack {
                        HStack (spacing : 13){
                            Image(systemName: "dollarsign.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                            VStack(alignment:.leading) {
                                Text(title)
                                    .font(.system(size: 24.4))
                                    .foregroundStyle(.white)
                                    .bold()
                                Text("\(date.formatted(date: .numeric, time: .shortened))")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.white)
        
                            }
                        }
                        Spacer()
                        Text("\(amount.formatted(.currency(code: "RON")))")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(6)
                            .bold()
                            .cornerRadius(10)
                    }
                    .foregroundColor(.gray).bold()
                    .frame(width: UIScreen.main.bounds.width - 70, height: 30)
                    .padding(.vertical, 28)
                    .padding(.horizontal, 15)
                    .background(
                        LinearGradient(
                               gradient: Gradient(colors: [
                                Color(color),
                                Color(color).opacity(0.8) ,
                                Color(color)
        
        
                               ]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing
                           ))
                    .cornerRadius(10)
                }
    }
}
struct ExpensesListView: View {
    
    @State private var expensesList : [Pleo.Expense]
    
    // Initializer with internal access level
    init(expensesList: [Pleo.Expense]) {
        _expensesList = State(initialValue: expensesList)
    }
    
    var body: some View {
        
        ForEach(expensesList) { expense in
            ExpensesListVassel(title: expense.title, date: expense.date, amount: expense.amount, category: expense.category)
            
        }
    }
}
#Preview {
    ExpensesListView(expensesList: [Pleo.Expense(title: "", amount: 12, description: "", category: "", date: Date.now, userId: "")])
}
