//
//  ProfileView.swift
//  Pleo
//
//  Created by Vinter Marco on 17.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text(viewModel.currentUser?.initials ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72,  height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack (alignment: .leading, spacing: 4 ) {
                        Text(viewModel.currentUser?.fullName ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(viewModel.currentUser?.emai ?? "")
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            
            Section("General") {
                HStack {
                    SettingsRowView(imageName: "gear",
                                    title: "version",
                                    tintColor: Color(.systemGray))
                    Spacer()
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Section("Account") {
                Button {
                    viewModel.signOut()
                    print("Sign Out ...")
                } label: {
                    SettingsRowView(
                        imageName: "arrow.left.circle.fill",
                        title: "Sign Out",
                        tintColor: .red)
                }
                
                Button {
                    print("Delete account... ")
                } label: {
                    SettingsRowView(
                        imageName: "xmark.circle.fill",
                        title: "Delete Account",
                        tintColor: .red)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}


// vintermarco98@gmail.com
// #Programmingwithsini2023
