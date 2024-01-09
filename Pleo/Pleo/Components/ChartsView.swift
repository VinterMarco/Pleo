//
//  ChartsView.swift
//  Pleo
//
//  Created by Vinter Marco on 24.12.2023.
//

import SwiftUI
import Charts

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var color : Color
    var id = UUID()
}

struct ChartsView: View {


    var week1 = 0
    var week2 = 0
    var week3 = 0
    var week4 = 0
    var spendingGoal = 2100
    
    
    
    var data: [ToyShape] = [
        .init(type: "1st Week", count: 5, color: Color.green),
        .init(type: "2nd Week", count: 4, color: Color.red),
        .init(type: "3rd Week", count: 4, color: Color.yellow),
        .init(type: "4th Week", count: 4, color: Color.blue)

    ]
    
    var body: some View {
        VStack {
            Chart {
          
                BarMark (
                        x: .value("week", "1st Week"),
                        y: .value("Total Count", week1)
                    )
                .foregroundStyle(week1 < spendingGoal ? .green : .red)
                BarMark (
                    x: .value("week", "2nd Week"),
                    y: .value("Total Count", week2)
                )
                .foregroundStyle(week2 < spendingGoal ? .green : .red)
                BarMark (
                    x: .value("week", "3rd Week"),
                    y: .value("Total Count", week3)
                )
                .foregroundStyle(week3 < spendingGoal ? .green : .red)
                BarMark (
                    x: .value("week", "4th Week"),
                    y: .value("Total Count", week4)
                )
                .foregroundStyle(week4 < spendingGoal ? .green : .red)
                RuleMark (y : .value("Goal", 2100))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3)
 
        
    }
}

#Preview {
    ChartsView()
}
