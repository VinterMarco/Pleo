//
//  Expenses.swift
//  Pleo
//
//  Created by Vinter Marco on 18.12.2023.
//

import Foundation


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
        title: "",
        amount: 0,
        description: "",
        category: "Car",
        date: Date.now,
        userId: "")
}

