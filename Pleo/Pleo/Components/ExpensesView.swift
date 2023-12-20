import SwiftUI



struct ExpenseItemView: View {
    let title: String
    let amount: String
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
                Text(amount)
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
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy" // Format as "Nov, 2023"
        dateFormatter.locale = Locale(identifier: "en_CH") // Set the locale to Switzerland
        return dateFormatter.string(from: date)
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
//                            .background(.red)
                            .opacity(0.03)
                            
                        }
                        Text("Expenses")
                            .foregroundStyle(.white)
                            .font(.title).fontWeight(.medium)
                        
                        VStack(alignment: .leading, spacing: -6) {
                            Text("Total")
                                .font(.system(size: 19))
                                .bold()
                            
                            HStack(spacing: geometry.size.width < 600 ? 150 : 140) {
                                Text("$5,020")
                                    .font(.system(size: geometry.size.width < 600 ? 30 : 34).bold())
                                    .foregroundStyle(.blue)
                                
                                Button {
                                    // Handle button action
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
                                }
                                
                            }
                            
                            Text("-$254 today")
                                .foregroundColor(.red)
                                .font(.system(size: geometry.size.width < 600 ? 14 : 15))
                        }
                        .padding()
                        .frame(width: geometry.size.width - 32)
                        .background(.white)
                        .cornerRadius(20)
                        
                        VStack(spacing: geometry.size.width < 600 ? 10 : 20) {
                            NavigationLink {
                                Text("Text")
                            } label: {
                                ExpenseItemView(title: "Take Out", amount: "$2,103", colorOfLabel: Color.green, labelImage: "bag")
                            }
                            ExpenseItemView(title: "Clothes", amount: "$2,103", colorOfLabel: Color.yellow, labelImage: "tag.circle.fill")
                            ExpenseItemView(title: "Utilities", amount: "$2,300", colorOfLabel: Color.purple, labelImage: "house")
                            ExpenseItemView(title: "Car", amount: "$1,2300", colorOfLabel: Color.blue, labelImage: "car")
                            ExpenseItemView(title: "Other", amount: "$1,2300", colorOfLabel: Color.pink, labelImage: "ellipsis.circle.fill")
                        }
                        .frame(height: 450)
                        .background(.clear)
                    }
                    .shadow(color: .gray, radius: 5)
                    .frame(width: geometry.size.width - 32, height: geometry.size.height - 150)
                }
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
