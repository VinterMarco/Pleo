//
//  EditExpensesView.swift
//  Pleo
//
//  Created by Vinter Marco on 09.01.2024.
//

import SwiftUI

struct EditExpensesView: View {
    
    @State  var title : String
    @State  var date : Date
    @State  var amount : Double
    @State var category : String
    @State var documentName : String
    @Environment(\.dismiss) private var dismiss

//    @ObservedObject var expenseManager = ExpenseManager()
    
    @Binding var presentationMode : PresentationMode
    
    // test
    @EnvironmentObject var expenseManager : ExpenseManager
    // 


    var body: some View {
        NavigationStack {
                VStack {
                    VStack(spacing : 13) {
                        VStack(alignment: .leading) {
                            Text("Goal Name")
                                .font(.footnote)
                                .foregroundStyle(.black)

                            TextField("Edit goal name", text: $title)
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
                                .foregroundStyle(.black)
                            TextField("Edit  Ammount", value: $amount, format: .currency(code: "RON"))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        
                        Button {
                            // more code to come
                            expenseManager.updateExpenseNameAndAmount(expenseId: documentName, newAmount: amount, newExpenseName: title)
                            dismiss()
                            presentationMode.dismiss()
                        } label: {
                            Text("Edit Expense")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color(
                                    red: 1.0 - 255 / 255.0,
                                    green: 1.0 - 190 / 255.0,
                                    blue: 1.0 - 152 / 255.0
                                ))
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }
                        
                        Button {
                            expenseManager.deleteExpensesByDocumentId(withId: documentName)
                            dismiss()
                            presentationMode.dismiss()
                        } label: {
                            Text("Delete Expense")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color(red: 204 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }

                }
            }
        }
    }
}

//#Preview {
//    EditExpensesView()
//}
