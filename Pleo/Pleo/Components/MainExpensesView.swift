//
//  MainExpensesView.swift
//  Pleo
//
//  Created by Vinter Marco on 24.12.2023.
//

import SwiftUI

struct MainExpensesView: View {
    
    var highestExpense = 0.0
    var body: some View {
        HStack (spacing : 10) {
            VStack  (alignment : .center , spacing : 30){
                Text("Highest Expense")
                    .font(.system(size: 11))
                Text("\(highestExpense.formatted(.currency(code: "RON")))")
                    .font(.system(size: 11))
                    .bold()

            }
            .frame(width: 90)
            Divider()
            VStack  (alignment : .center , spacing : 30){
                Text("Highest Day")
                    .font(.system(size: 11))
                Text("RON 5240")
                    .font(.system(size: 14))
                    .bold()

            }
            .frame(width: 90)

            Divider()
            VStack  (alignment : .center , spacing : 30){
                Text("Lowest Day")
                    .font(.system(size: 11))
                Text("RON 70")
                    .font(.system(size: 14))
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
