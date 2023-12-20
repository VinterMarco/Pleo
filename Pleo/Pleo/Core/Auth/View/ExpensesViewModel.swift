import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ExpenseManager: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var expenses: [Expense] = []

    private var db = Firestore.firestore()

    init() {
        getExpenses()
    }

    func addExpense(_ expense: Expense) {
        do {
          let  collectionRef = try db.collection("expenses").addDocument(from: expense)
          
            
            // provizoriu
        
            let categoryCollection = db.collection("expensesByCategory").document(expense.category).collection("expenses")
            var expenseWithCategory = expense
            try categoryCollection.addDocument(from: expenseWithCategory)
            
            // test
                         

        } catch {
            print("Error adding expense: \(error)")
        }
    }

    private func getExpenses() {
        db.collection("expenses").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error ?? NSError())")
                return
            }

            self.expenses = documents.compactMap { queryDocumentSnapshot -> Expense? in
                try? queryDocumentSnapshot.data(as: Expense.self)
            }
        }
    }
}

