import SwiftUI



struct ExpenseItemView: View {
    let title: String
    let amount: Double
    let colorOfLabel : Color
    let labelImage : String
    
    
    var body: some View {
        HStack(spacing : 10) {
            VStack {
                Circle()
                    .fill(colorOfLabel)
                    .frame(width: 40, height: 40) // Adjust the size as needed
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1)
                    )
                    .overlay(
                        Image(systemName: labelImage) // System image for take-out food
                            .resizable()
                            .foregroundStyle(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 24) // Adjust the size as needed
                    )
            }
            VStack {
                Text(title)
                    .bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            VStack {
                Text("\(amount.formatted(.currency(code: "RON")))")
                    .foregroundStyle(.blue)
                    .bold()
            }
        }
        .padding(20)
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 0.2)
    }
}


struct ExpensesView: View {
    
    
    
    
    @State private var date = Date.now
    @State private var isDatePickerVisible = false
    @State private var addExpenseIsVisible = false
    @ObservedObject var expenseManager = ExpenseManager()
    
    @State  var allExpensesSumState = 0.0
    @State  var availableBudget = 15000.0
    @State  var moneySpentToday = 0.0
    
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
    
    
 
    
    
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy" // Format as "Nov, 2023"
        dateFormatter.locale = Locale(identifier: "en_CH") // Set the locale to Switzerland
        return dateFormatter.string(from: date)
    }
    
    
    
    
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
    
    

    // Function to calculate the sum of expenses for each category with color and string
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
    
    
    // Function to calculate the sum of expenses for each category with color and string
    func getCategorySumForCurrentDay() {
        let expensesForToday = expenseManager.currentDayExpenses
        moneySpentToday = 0
        for expense in expensesForToday {
            moneySpentToday += expense.amount
        }
   }

    
    // Function to get color and icon for a given category
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
                                
                                Text(formattedDate)
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
                            .onChange(of: date, perform: { newDate in
                                let year = getYear(from: newDate)
                                let month = getMonth(from: newDate)
                                expenseManager.getExpensesByMonth(forMonth: month, year: year)
                            })
                            
                        }
                        Text("Expenses")
                            .foregroundStyle(.white)
                            .font(.title).fontWeight(.medium)
                        
                        VStack(alignment: .leading, spacing: -6) {
                            Text("Total")
                                .font(.system(size: 22))
                                .bold()
                            
                            HStack(spacing: geometry.size.width < 600 ? 100 : 110) {
                                Text("\((availableBudget - allExpensesSumState).formatted(.currency(code: "RON")))")
                                    .font(.system(size: geometry.size.width < 600 ? 23 : 36).bold())
                                    .foregroundStyle(.blue)
                                
                                Button {
                                    addExpenseIsVisible.toggle()
                                    
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(20)
                                        .font(.system(size: geometry.size.width < 600 ? 24 : 30))
                                        .bold()
                                        .background(.blue)
                                        .clipShape(.circle)
                                        .foregroundColor(.white)
                                        .shadow(color: .blue, radius: 2)
                                }
                                .sheet(isPresented: $addExpenseIsVisible) {
                                    AddExpensesSheetView()
                                        .presentationDetents([.fraction(0.90)])
                                        .onDisappear {
                                                 getCategorySumForCurrentDay()
                                             }
                                }
                                
                            }
                            Text("-\(moneySpentToday.formatted(.currency(code: "RON"))) today")
                                .foregroundColor(.red)
                                .font(.system(size: geometry.size.width < 600 ? 15 : 15))
                        }
                        .padding()
                        .frame(width: geometry.size.width - 32)
                        .background(.white)
                        .cornerRadius(20)
                        
                        VStack(spacing: geometry.size.width < 600 ? 10 : 20) {
                            ForEach(getCategorySum(expenses: expenseManager.currentMontExpenses ), id: \.category) { categorySum in
                                NavigationLink {
                                        ExpensesListView(expensesList: categorySum.entries)
                                } label: {
                                    ExpenseItemView(title: categorySum.category, amount: categorySum.sum, colorOfLabel: categorySum.color, labelImage: categorySum.icon)


                                }
                            }

                            
                        }
                        .frame(height: 450)
                        .background(.clear)
                    }
                    .shadow(color: .gray, radius: 5)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 150)
                }
            }
            .onAppear {
                expenseManager.getExpensesByMonth(forMonth: self.selectedMonth, year: self.selectedYear)
                getCategorySumForCurrentDay()
                
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            
            
            
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
