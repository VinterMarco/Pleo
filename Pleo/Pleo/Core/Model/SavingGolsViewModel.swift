//
//  SavingGolsViewModel.swift
//  Pleo
//
//  Created by Vinter Marco on 03.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class  SavingGoalsManager : ObservableObject {
    
    @Published var savingGoals: [SavingGoal] = []
    private var db = Firestore.firestore()
    
    init() {
        getSaveGoals()
    }
    
    func addSaveGoals(_ goal: SavingGoal) {
        do {
            let _ = try db.collection("savingGoals").addDocument(from: goal)
        } catch {
            print("Error adding expense: \(error)")
        }
    }
    
    
    
    func updateGoalNameAndTargetAmount(goalId: String, newTargetAmount: Double, newSavingGoalName : String) {
        let documentRef = db.collection("savingGoals").document(goalId)
        
        let updateData: [String: Any] = [
             "targetAmount": newTargetAmount,
             "title": newSavingGoalName
         ]
        documentRef.updateData(updateData) { error in
            if let error = error {
                print("Error updating save goal: \(error)")
            } else {
                print("Save goal updated successfully")
            }
        }

    }
    
    
    
    func updateSaveGoal(goalId: String, newAddedAmount: Double) {
        let documentRef = db.collection("savingGoals").document(goalId)
        documentRef.updateData(["addedAmount": newAddedAmount]) { error in
            if let error = error {
                print("Error updating save goal: \(error)")
            } else {
                print("Save goal updated successfully")
            }
        }
    }
    
    
    
    
    
    func getSaveGoals() {
        db.collection("savingGoals")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error ?? NSError())")
                    return
                }
                
                self.savingGoals = documents.compactMap { document in
                    do {
                        return try document.data(as: SavingGoal.self)
                    } catch {
                        print("Error decoding expense: \(error)")
                        return nil
                    }
                }
            }
    }
    
    
    
    func deleteSaveGoal(withId goalId: String) {
        let documentRef = db.collection("savingGoals").document(goalId)
        // Delete the document
        documentRef.delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    
}
