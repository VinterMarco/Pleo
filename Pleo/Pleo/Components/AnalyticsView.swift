//
//  AnalyticsView.swift
//  Pleo
//
//  Created by Vinter Marco on 24.12.2023.
//

import SwiftUI
import Charts



struct AnalyticsView: View {
    
    @ObservedObject var expenseManager = ExpenseManager()
    @State private var date : Date = Date.now
    @State  var allExpensesSumState = 0.0
    @State  var highestExpenseStateVar = 0.0

    
    // set them by category
    func groupExpensesByCategory(expenses: [Pleo.Expense]) -> [String: [Pleo.Expense]] {
        var groupedExpenses = [String: [Pleo.Expense]]()

        for expense in expenses {
            let category = expense.category
            if var categoryExpenses = groupedExpenses[category] {
                categoryExpenses.append(expense)
                groupedExpenses[category] = categoryExpenses
            } else {
                groupedExpenses[category] = [expense]
            }
        }
        return groupedExpenses
    }

    
    // highest expense
    
    func getHighestExpense() {
        var highestExense = -2000000.0
        print(expenseManager.expenses)
        
        var currentMonthExpenses = expenseManager.expenses

        for expense in currentMonthExpenses {
            if expense.amount > highestExense {
//                print(expense.amount)
                highestExense = expense.amount
            }
        }
        highestExpenseStateVar = highestExense
        print("Amount : \(highestExense)")
    }
    
    
    // highest day expense
    
    func highestDayExpense() {
        
    }
    
    
    // sum the category
    func getCategorySum(expenses: [Pleo.Expense]) -> [(category: String, sum: Double, color: Color, icon: String, entries: [Pleo.Expense])] {
        let groupedExpenses = groupExpensesByCategory(expenses: expenses)
        var categorySums = [(category: String, sum: Double, color: Color, icon: String, entries: [Pleo.Expense])]()
        for (category, categoryExpenses) in groupedExpenses {
            let sum = categoryExpenses.reduce(0.0) { $0 + $1.amount }
            let colorAndIcon = getColorAndIcon(for: category)
            categorySums.append((category: category, sum: sum, color: colorAndIcon.color, icon: colorAndIcon.icon, entries: categoryExpenses))
        }
        var allExpensesSum = 0.0
        for categorySum in categorySums {
            allExpensesSum += categorySum.sum
            
        }
        allExpensesSumState = allExpensesSum
        return categorySums
    }
    
    // give color 
    func getColorAndIcon(for category: String) -> (color: Color, icon: String) {
        switch category.lowercased() {
        case "take out":
            return (color: .green, icon: "bag.fill")
        case "clothes":
            return (color: .yellow, icon: "tag.circle.fill")
        case "utilities":
            return (color: .blue, icon: "house.fill")
        case "car":
            return (color: .purple, icon: "car.fill")
        default:
            return (color: .pink, icon: "ellipsis.circle.fill")
        }
    }
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Color.blue.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                        Color.white.ignoresSafeArea(edges: .top)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                                    .font(.system(size: 26))
                                
                                Text("Dec, 2023")
                                    .fontDesign(.rounded)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            DatePicker (
                                "", selection: $date, displayedComponents: .date
                            )
                            .datePickerStyle(.compact) // Use custom MonthPickerStyle
                            .fontDesign(.monospaced) // Customize the font
                            .frame(width: 30)
                            .opacity(0.03)
                            
                            
                        }
                        Text("Analytics")
                            .foregroundColor(.white)
                            .font(.title).fontWeight(.medium)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            VStack (spacing : 30) {
                                ChartsView()
                                    .frame(height: 200)
                                HStack {
                                    PieChartView(expensesByCategory: getCategorySum(expenses: expenseManager.expenses))
                                        .frame(height: 200)
                                    
                                }
                            }
                            
                        }
                        .padding(5)
                        .frame(width: geometry.size.width - 32)
                        .cornerRadius(20)
                        MainExpensesView(highestExpense: highestExpenseStateVar)
                        
                        
                    }
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 150)
                }
                .onAppear {
                    expenseManager.getExpensesByMonth(forMonth: 12, year: 2023)
                    getHighestExpense()

                }
            }
        }
    }
}

#Preview {
    AnalyticsView()
}
