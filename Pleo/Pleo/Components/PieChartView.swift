//
//  PieChartView.swift
//  Pleo
//
//  Created by Vinter Marco on 24.12.2023.
//

import SwiftUI
import Charts




struct PieChartView: View {
    
    typealias ExpenseData = [(category: String, sum: Double, color: Color, icon: String, entries: [Pleo.Expense])]
    var expensesByCategory : ExpenseData
    
    var body: some View {
        HStack (spacing : 5) {
            Chart {
                ForEach(expensesByCategory, id: \.category) { expenses in
                    SectorMark (
                        angle: .value("Cup", expenses.sum),
                        innerRadius: .ratio(0.3),
                        angularInset: 0.4
                    )
                    .foregroundStyle(expenses.color)
                }
            }
            .chartLegend(.hidden)
            .frame(width: 130)

            
            Spacer()

            VStack(alignment: .leading, spacing: 5) {
                ForEach(expensesByCategory, id: \.category) { expenses in
                    HStack {
                        HStack {
                            
                            Circle()
                                .frame(width: 7)
                                .foregroundColor(expenses.color)
                            Text("\(expenses.category)")
                                .foregroundColor(.black)
                                .bold()
                                .font(.system(size: 10))
                        }
                        Spacer()
                        Text("\(expenses.sum.formatted(.currency(code: "RON")))")
                            .foregroundStyle(.red)
                            .font(.system(size: 10))
                    }
                }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3)
    }
}

#Preview {
    PieChartView(expensesByCategory: [])
}
