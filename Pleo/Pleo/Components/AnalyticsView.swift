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
    @State var maxTotal: Double = -9223372036854775808.0
    @State var minDate: Date?
    @State var minTotal: Double = 2_147_483_647.0
    
    @State  var firstWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek1 = 0
    @State  var secondWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek2 = 0
    @State var thirdWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek3 = 0
    @State var fourthWeekExpenses = [Pleo.Expense]()
    @State  var sumWeek4 = 0
    
    
    
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy" // Format as "Nov, 2023"
        dateFormatter.locale = Locale(identifier: "en_CH") // Set the locale to Switzerland
        return dateFormatter.string(from: date)
    }
    
    var selectedYear : Int {
        let currentDate = date
        let calendar = Calendar.current
        return calendar.component(.year, from: currentDate)
    }
    var selectedMonth : Int {
        let currentDate = date
        let calendar = Calendar.current
        return calendar.component(.month, from: currentDate)
    }
    
    
    func getYear(from date: Date) -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return year
    }
    
    func getMonth(from date: Date) -> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        return month
    }
    
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
        sumWeek1 = 0
        sumWeek2 = 0
        sumWeek3 = 0
        sumWeek4 = 0
        
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
        
    }
    
    
    // highest expense
    func getHighestExpense() {
        print(expenseManager.currentMontExpenses)
        var highestExense = -9223372036854775808.0
        var highestDate = Date.now
        
        var currentMonthExpenses = expenseManager.currentMontExpenses
        for expense in currentMonthExpenses {
            if expense.amount > highestExense {
                highestExense = expense.amount
                highestDateForSending = expense.date
            }
        }
        highestExpenseStateVar = highestExense
        if highestExpenseStateVar  == -9223372036854775808.0 {
            highestExpenseStateVar = 0
            highestDateForSending = Date.now
        }
    }
    
    
    
    // highest day expense
    func highestDayExpense() {
        var dailyTotal: [Date: Double] = [:]
        
        maxTotal = -9223372036854775808.0
        maxDate = nil
        
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
        
        if maxTotal == -9223372036854775808.0 {
            maxTotal = 0
            minDate = Date.now
        }
    }
    
    // Lowest day expense  -- looks fixed
    func lowestDayExpense() {
        var dailyTotal: [Date: Double] = [:]
        minTotal = 2_147_483_647.0
        minDate = nil
        
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
            
            print(dailyTotal)
            
            // Update minDate and minTotal if needed
            
            if let total = dailyTotal[dateOnly], total < minTotal {
                minTotal = total
                minDate = dateOnly
            }
        }
        
        if minTotal == 2_147_483_647.0 {
            minTotal = 0
            maxDate = Date.now
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
                        Color(red: 255 / 255.0, green: 190 / 255.0, blue: 152 / 255.0).ignoresSafeArea(edges: .top)
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
                                
                                Text("\(formattedDate)")
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
                            .onChange(of: date, perform: { newDate in
                                let year = getYear(from: newDate)
                                let month = getMonth(from: newDate)
                                expenseManager.getExpensesByMonth(forMonth: month, year: year)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    getHighestExpense()
                                    lowestDayExpense()
                                    highestDayExpense()
                                    groupExpensesInFourWeeksInAMonth()
                                }
                            })
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
                                .opacity(expenseManager.currentMontExpenses.isEmpty ? 0 : 1)
                                .frame(height: 200)
                                
                                if expenseManager.currentMontExpenses.isEmpty {
                                    Text("No data available for this month.")
                                        .font(.title3).bold()
                                        .offset(x: 0, y: 0) // Adjust the offset values as needed
                                        .animation(.easeInOut(duration: 1.0))
                                    
                                }
                                
                                HStack {
                                    PieChartView(expensesByCategory: getCategorySum(expenses: expenseManager.currentMontExpenses))
                                        .opacity(expenseManager.currentMontExpenses.isEmpty ? 0 : 1)
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
                        .opacity(expenseManager.currentMontExpenses.isEmpty ? 0 : 1)
                        
                    }
                    
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 150)
                }
                
                .onAppear {
                    expenseManager.getExpensesByMonth(forMonth: selectedMonth, year: selectedYear)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        getHighestExpense()
                        lowestDayExpense()
                        highestDayExpense()
                        groupExpensesInFourWeeksInAMonth()
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    AnalyticsView()
}
