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
    @State var documentName : String
    
    @Environment(\.presentationMode) var presentationMode

    
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
    
    // vars
    
    @State var openExpensesSheet : Bool = false
    
    // test
    @EnvironmentObject var expenseManager : ExpenseManager

    //
    
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
                            .font(.system(size: 23.4))
                            .foregroundStyle(.white)
                            .bold()
                        Text("\(date.formatted(date: .numeric, time: .shortened))")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                        
                    }
                }
                Spacer()
                Text("\(amount.formatted(.currency(code: "RON")))")
                    .foregroundColor(.white)
                    .font(.system(size: 17))
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
        .onTapGesture {
            openExpensesSheet.toggle()
        }
        .sheet(isPresented: $openExpensesSheet, onDismiss: {
            // more code to come
            
        }) {
            EditExpensesView(title: title, date: date, amount: amount, category: category, documentName: documentName, presentationMode : presentationMode)
                .presentationDetents([.medium])
        }
    }
}
struct ExpensesListView: View {
    
    @State private var expensesList : [Pleo.Expense]

    // Initializer with internal access level
    init(expensesList: [Pleo.Expense]) {
        _expensesList = State(initialValue: expensesList)
        print(expensesList)
    }
    
    var body: some View {
       
        ScrollView {
            VStack {
                ForEach(expensesList) { expense in
                    ExpensesListVassel(title: expense.title, date: expense.date, amount: expense.amount, category: expense.category, documentName: expense.documenttName ?? "")
                }
            }
            .navigationTitle(expensesList[0].category)
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
#Preview {
    ExpensesListView(expensesList: [Pleo.Expense(title: "", amount: 12, description: "", category: "", date: Date.now, userId: "")])
}
