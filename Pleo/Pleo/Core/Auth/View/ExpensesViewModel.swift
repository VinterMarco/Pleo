import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ExpenseManager: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published var expenses: [Expense] = []
    @Published var currentMontExpenses: [Expense] = []
    @Published var currentDayExpenses: [Expense] = []
    private var db = Firestore.firestore()
    
    init() {
        getExpenses()
        getExpensesForCurrentDay()
    }
    
    func addExpense(_ expense: Expense) {
        do {
            let _ = try db.collection("expenses").addDocument(from: expense)
        } catch {
//            print("Error adding expense: \(error)")
        }
    }
    
    
    
    func getExpenses() {
        db.collection("expenses")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching documents: \(error ?? NSError())")
                    return
                }
                
                self.expenses = documents.compactMap { document in
                    do {
                        return try document.data(as: Expense.self)
                    } catch {
//                        print("Error decoding expense: \(error)")
                        return nil
                    }
                }
            }
    }
    
    
    func getExpensesForCurrentDay() {
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? currentDate

        db.collection("expenses")
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThan: endOfDay)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching documents: \(error ?? NSError())")
                    return
                }

                self.currentDayExpenses = documents.compactMap { document in
                    do {
                        return try document.data(as: Expense.self)
                    } catch {
//                        print("Error decoding expense: \(error)")
                        return nil
                    }
                }
            }
    }
    
    
    // edit expenses
    
    func updateExpenseNameAndAmount(expenseId: String, newAmount: Double, newExpenseName : String) {
        let documentRef = db.collection("expenses").document(expenseId)
        
        let updateData: [String: Any] = [
             "amount": newAmount,
             "title": newExpenseName
         ]
        documentRef.updateData(updateData) { error in
            if let error = error {
                print("Error updating expense: \(error)")
            } else {
                print("Expese updated successfully")
            }
        }

    }
    
    // delete expenses
    
    func deleteExpensesByDocumentId(withId expensesId: String) {
        let documentRef = db.collection("expenses").document(expensesId)
        // Delete the document
        documentRef.delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    //
    
    
    func getExpensesByMonth(forMonth month: Int, year: Int) {
          let startComponents = DateComponents(year: year, month: month, day: 1)
          guard let startDate = Calendar.current.date(from: startComponents),
                let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate) else {
              return
          }

          db.collection("expenses")
              .whereField("date", isGreaterThanOrEqualTo: startDate)
              .whereField("date", isLessThan: endDate)
              .addSnapshotListener { querySnapshot, error in
                  guard let documents = querySnapshot?.documents else {
//                      print("Error fetching documents: \(error ?? NSError())")
                      return
                  }

                  self.currentMontExpenses = documents.compactMap { document in
                      do {
                          return try document.data(as: Expense.self)
                      } catch {
//                          print("Error decoding expense: \(error)")
                          return nil
                      }
                  }
              }
      }
}

