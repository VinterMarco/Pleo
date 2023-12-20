//
//  Expenses.swift
//  Pleo
//
//  Created by Vinter Marco on 18.12.2023.
//

import Foundation


//Expense Name : Smart Watch
//Description : I bought an Apple Watch
//Ammount : 520
//Category : Other
//Date : 2023-12-20 14:27:32 +0000

struct Expense : Identifiable, Codable {
    var id = UUID()
    var title : String
    var amount : Double
    var description : String
    var category : String
    var date : Date
    var userId : String
}



extension Expense {
    static var MOCK_EXPENSE = Expense(
        title: "Title",
        amount: 22.5,
        description: "",
        category: "car",
        date: Date.now,
        userId: "not found")
}

