//
//  SavingGoal.swift
//  Pleo
//
//  Created by Vinter Marco on 03.01.2024.
//

import Foundation
import FirebaseFirestoreSwift


struct SavingGoal : Identifiable, Codable {
    @DocumentID var documenttName: String?
    var id = UUID()
    var title : String
    var addedAmount : Double
    var targetAmount : Double
    var lastDepositDate : Date
    var userId : String
}

extension SavingGoal {
    static var MOCK_Save_Goal = SavingGoal(
        title: "",
        addedAmount: 0.0,
        targetAmount: 0.0,
        lastDepositDate: Date.now,
        userId: ""
    )
}

