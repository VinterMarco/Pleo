//
//  AddExpensesSheetView.swift
//  Pleo
//
//  Created by Vinter Marco on 20.12.2023.
//

import SwiftUI

struct AddExpensesSheetView: View {
    
    @State private var ammount = 0
    @State private var name = ""
    @State private var description = ""
    @State private var category = "Take Out"
    @State private var date = Date.now
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @StateObject private var expenseManager = ExpenseManager()
    
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy" // Format as "Nov, 2023"
        dateFormatter.locale = Locale(identifier: "en_CH") // Set the locale to Switzerland
        return dateFormatter.string(from: date)
    }
    
    
   
    
    
    var categories = ["Take Out","Clothes","Utilities","Car","Other"]
    
    
    var body: some View {
        VStack(spacing : 13) {
            Text("Expense")
                .bold()
                .font(.system(size: 33))
            
            VStack(alignment: .leading) {
                Text("Expense name")
                    .font(.footnote)
                TextField("Enter expense name", text: $name)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 0.6)
                    )
            }
            
            
            
            VStack(alignment: .leading) {
                Text("Ammount")
                    .font(.footnote)
                TextField("Ammount", value: $ammount, format: .currency(code: "RON"))
                    .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 0.6)
                    )
            }
            
            VStack(alignment: .leading) {
                Text("Category")
                    .font(.footnote)
                HStack (spacing : 2) {
                    Text("Choose a category")
                    
                    Spacer()
                    Picker("", selection: $category) {
                        ForEach(categories, id : \.self) {
                            Text($0)
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
            
            
            VStack(alignment: .leading) {
                Text("Date")
                    .font(.footnote)
                
                ZStack {
                    HStack {
                        Text("\(formattedDate)")
                            .frame(width: 100)
                        Spacer()
                        Image(systemName: "calendar")
                            .offset(x : -20)
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .opacity(0.03)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.6)
                        )
                    
                    
                }
                .offset(y : 5)
                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
            }
            
            Button {
                print("Expense Name : \(name)")
                print("Description : \(description)")
                print("Ammount : \(ammount)")
                print("Category : \(category)")
                print("Date : \(date)")
                let newExpense = Expense(title: name, amount: Double(ammount), description: "N/A Feature", category: category, date: date, userId: viewModel.currentUser?.id ?? "unasigned to a user")
                expenseManager.addExpense(newExpense)
                expenseManager.getExpensesForCurrentDay()
                dismiss()
            } label: {
                Text("Add expense")
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

#Preview {
    AddExpensesSheetView()
}
