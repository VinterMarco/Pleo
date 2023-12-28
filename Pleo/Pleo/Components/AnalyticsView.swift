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
    @State var highestDateForSending: Date = Date.now
    @State var maxDate: Date?
    @State var maxTotal: Double = 0.0
    @State var minDate: Date?
    @State var minTotal: Double = 111111111111.0
    
    @State  var firstWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek1 = 0
    @State  var secondWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek2 = 0
    @State var thirdWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek3 = 0
    @State var fourthWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek4 = 0

    
    
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
    
    
     func groupExpensesInFourWeeksInAMonth () {
         firstWeekExpenses = []
         secondWeekExpenses = []
         thirdWeekExpenses = []
         fourthWeekExpenses = []
        
        for exepenses in expenseManager.currentMontExpenses {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let extractedDate = dateFormatter.string(from: exepenses.date)
            if let date = dateFormatter.date(from: extractedDate) {
                let calendar = Calendar.current
                let dayOfMonth = calendar.component(.day, from: date)
                let strToNumb = Int(dayOfMonth)
                switch strToNumb {
                case 1...7:
                    firstWeekExpenses.append(exepenses)
                case 8...14:
                    secondWeekExpenses.append(exepenses)
                case 15...21:
                    thirdWeekExpenses.append(exepenses)
                case 22...31:
                    fourthWeekExpenses.append(exepenses)
                default:
                    break
                }
            } else {
//                print("Invalid date string")
            }
            
        }
        print("1")
        print(firstWeekExpenses)
        print(type(of: firstWeekExpenses))
         
         
         for week1Iterator in firstWeekExpenses {
             sumWeek1 += Int(week1Iterator.amount)
         }
         for week2Iterator in secondWeekExpenses {
             sumWeek2 += Int(week2Iterator.amount)
         }
         for week3Iterator in thirdWeekExpenses {
             sumWeek3 += Int(week3Iterator.amount)
         }
         for week4Iterator in fourthWeekExpenses {
             sumWeek4 += Int(week4Iterator.amount)
         }
         
         
         print(sumWeek1)
         print(sumWeek2)
         print(sumWeek3)
         print(sumWeek4)
//        print("2")
//        print(secondWeekExpenses)
//        print("3")
//        print(thirdWeekExpenses)
//        print("4")
//        print(fourthWeekExpenses)
    }
    
    
    // highest expense
    func getHighestExpense() {
        var highestExense = -2000000.0
        var highestDate = Date.now
        var currentMonthExpenses = expenseManager.currentMontExpenses
        for expense in currentMonthExpenses {
            if expense.amount > highestExense {
                highestExense = expense.amount
                highestDateForSending = expense.date
            }
        }
        highestExpenseStateVar = highestExense
        if highestExpenseStateVar  == -2000000.0 {
            highestExpenseStateVar = 0
        }
    }
    
    
    // highest day expense
    func highestDayExpense() {
        var dailyTotal: [Date: Double] = [:]
        // Iterate through expenses and update the daily total
        for expense in expenseManager.currentMontExpenses {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: expense.date)
            let dateOnly = calendar.date(from: components)!
            
            if let existingTotal = dailyTotal[dateOnly] {
                dailyTotal[dateOnly] = existingTotal + expense.amount
            } else {
                dailyTotal[dateOnly] = expense.amount
            }
            
            // Update maxDate and maxTotal if needed
            if let total = dailyTotal[dateOnly], total > maxTotal {
                maxTotal = total
                maxDate = dateOnly
            }
        }
    }
    
    // Lowest day expense
    func lowestDayExpense() {
        var dailyTotal: [Date: Double] = [:]
        
        
        // Iterate through expenses and update the daily total
        for expense in expenseManager.currentMontExpenses {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: expense.date)
            let dateOnly = calendar.date(from: components)!
            
            if let existingTotal = dailyTotal[dateOnly] {
                dailyTotal[dateOnly] = existingTotal + expense.amount
            } else {
                dailyTotal[dateOnly] = expense.amount
            }
            
            // Update minDate and minTotal if needed
            if let total = dailyTotal[dateOnly], total < minTotal {
                minTotal = total
                minDate = dateOnly
            }
        }
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
                            .datePickerStyle(.compact)
                            .fontDesign(.monospaced)
                            .frame(width: 30)
                            .opacity(0.03)
                            
                            
                        }
                        Text("Analytics")
                            .foregroundColor(.white)
                            .font(.title).fontWeight(.medium)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            VStack (spacing : 30) {
                                ChartsView(
                                    week1: sumWeek1,
                                    week2: sumWeek2,
                                    week3: sumWeek3,
                                    week4: sumWeek4
                                )
                                    .frame(height: 200)
                                HStack {
                                    PieChartView(expensesByCategory: getCategorySum(expenses: expenseManager.currentMontExpenses))
                                        .frame(height: 200)
                                    
                                }
                            }
                            
                        }
                        .padding(5)
                        .frame(width: geometry.size.width - 32)
                        .cornerRadius(20)
                        MainExpensesView(
                            highestExpense: highestExpenseStateVar,
                            highestExpenseDate: highestDateForSending, highestDay: maxDate ?? Date.now ,
                            lowestDay : minDate ?? Date.now ,
                            maxTotal: Int(maxTotal),
                            minTotal: Double(Int(minTotal))
                            
                        )
                    }
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 150)
                }
                .onAppear {
                    expenseManager.getExpensesByMonth(forMonth: 12, year: 2023)
                    getHighestExpense()
                    lowestDayExpense()
                    highestDayExpense()
                    groupExpensesInFourWeeksInAMonth()
                    
                }
            }
        }
    }
}

#Preview {
    AnalyticsView()
}
