//
//  MainExpensesView.swift
//  Pleo
//
//  Created by Vinter Marco on 24.12.2023.
//

import SwiftUI

struct MainExpensesView: View {
    
    var highestExpense = 0.0
    var highestExpenseDate = Date.now
    var highestDay = Date.now
    var lowestDay = Date.now
    var highestExpensesDayFormatted : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale(identifier: "en_CH")
        return dateFormatter.string(from: highestExpenseDate)
    }
    var highestDayFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM" 
        dateFormatter.locale = Locale(identifier: "en_CH")
        return dateFormatter.string(from: highestDay)
    }
    var lowestDayFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale(identifier: "en_CH")
        return dateFormatter.string(from: lowestDay)
    }
    
    var maxTotal = 0
    var minTotal = 0.0
    
    var body: some View {
        HStack (spacing : 10) {
            VStack  (alignment : .center , spacing : 10){
                Text("Highest Expense")
                    .font(.system(size: 11))
                Text("\(highestExpense.formatted(.currency(code: "RON")))")
                    .font(.system(size: 11))
                    .bold()
                Text("\(highestExpensesDayFormatted)")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .bold()

            }
            .frame(width: 90)
            Divider()
            VStack  (alignment : .center , spacing : 10){
                Text("Highest Day")
                    .font(.system(size: 11))
                Text("\(maxTotal.formatted(.currency(code: "RON")))")
                    .font(.system(size: 11))
                    .bold()
                Text("\(highestDayFormatted)")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .bold()

            }
            .frame(width: 90)

            Divider()
            VStack  (alignment : .center , spacing : 10){
                Text("Lowest Day")
                    .font(.system(size: 11))
                Text("\(minTotal.formatted(.currency(code: "RON")))")
                    .font(.system(size: 11))
                    .bold()

                Text("\(lowestDayFormatted)")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .bold()
            }
            .frame(width: 90)

        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding( .horizontal, 5)
        .padding(.vertical, 30)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3)

    }
}

#Preview {
    MainExpensesView()
}
