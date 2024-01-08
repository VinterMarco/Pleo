//
//  EditModeOnSavings.swift
//  Pleo
//
//  Created by Vinter Marco on 08.01.2024.
//

import SwiftUI

struct EditModeOnSavings: View {
    
    @State var savings : SavingGoal
    @EnvironmentObject var viewModel : AuthViewModel
    @EnvironmentObject var savingsManager : SavingGoalsManager

    //
    @Binding var presentationMode: PresentationMode
    //
    
    //
    
    @State private var typeOfGoal = "New Goal"
    @State private var goals = ["New Goal", "Existing Goal"]
    @State private var amount = 0.0
    @State private var lastDepositDate = Date.now
    @State private var lastDepositString =  "2024-01-05"
    @State var goalsList  = ["a","b","c"]
    @State  var selectedSavingPlan:String = ""
    
    
    @State private var selectedSavingPlanID =  "id"
    @Environment(\.dismiss) private var dismiss
    
//    @Environment(\.presentationMode) var presentationMode

    
    //
    var body: some View {
        NavigationStack {
                VStack {
                    VStack(spacing : 13) {
                        VStack(alignment: .leading) {
                            Text("Goal Name")
                                .font(.footnote)
                                .foregroundStyle(.black)

                            TextField("Edit goal name", text: $savings.title)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        VStack(alignment: .leading) {
                            Text("Target Ammount")
                                .font(.footnote)
                                .foregroundStyle(.black)
                            TextField("Edit Target Ammount", value: $savings.targetAmount, format: .currency(code: "RON"))
                                .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 0.6)
                                )
                        }
                        
                        
                        
                        Button {
                            // more code to come 
                            savingsManager.updateGoalNameAndTargetAmount(goalId: savings.documenttName ?? "", newTargetAmount: savings.targetAmount, newSavingGoalName: savings.title)
                            dismiss()
                            presentationMode.dismiss()
                        } label: {
                            Text("Edit Saving Goal")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color(
                                    red: 1.0 - 255 / 255.0,
                                    green: 1.0 - 190 / 255.0,
                                    blue: 1.0 - 152 / 255.0
                                ))
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }
                        
                        Button {
                            savingsManager.deleteSaveGoal(withId: savings.documenttName ?? "")
                            dismiss()
                            presentationMode.dismiss()
                        } label: {
                            Text("Delete Saving Goal")
                                .bold()
                                .font(.title3)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 24)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color(red: 204 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
                                .clipShape(.buttonBorder)
                                .offset(y : 20)
                            
                        }

                }
            }            
        }
    }
}

//#Preview {
//    EditModeOnSavings(savings: SavingGoal.MOCK_Save_Goal)
//}
