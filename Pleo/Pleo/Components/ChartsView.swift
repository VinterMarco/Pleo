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
    
    var data: [ToyShape] = [
        .init(type: "1st Week", count: 5, color: Color.green),
        .init(type: "2nd Week", count: 4, color: Color.red),
        .init(type: "3rd Week", count: 4, color: Color.yellow),
        .init(type: "4th Week", count: 4, color: Color.blue)

    ]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(data) { datum in
                    BarMark (
                        x: .value("Shape Type", datum.type),
                        y: .value("Total Count", datum.count)
                    )
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
    ChartsView()
}
