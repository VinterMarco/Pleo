//
//  RegistrationView.swift
//  Pleo
//
//  Created by Vinter Marco on 17.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : AuthViewModel


    
    var body: some View {
            VStack {
                
                // image
                
                Image(.pleoBetaLogo2)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 450, height: 120)
                    .padding(.vertical, 32)
                    .offset(/*@START_MENU_TOKEN@*/CGSize(width: 10.0, height: 10.0)/*@END_MENU_TOKEN@*/)
                    .offset(y: -25)
                    .padding(.bottom, 6)
                
                // form fields
                
                VStack (spacing: 24 ) {
                    InputView(
                        text: $email,
                        title: "Email Address",
                        placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(
                        text: $fullname,
                        title: "Full Name",
                        placeholder: "Enter your full name")
                    
                    InputView(
                        text: $password,
                        title: "Password",
                        placeholder: "Enter your password",
                        isSecureField: true)
                    .autocapitalization(.none)
                    
                    InputView(
                        text: $confirmPassword,
                        title: "Confirm Password",
                        placeholder: "Cofirm your password",
                        isSecureField: true)
                    .autocapitalization(.none)
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // btns
                
                Button {
                    Task {
                        try await viewModel.createUser(withEmail: email,
                                                        password: password,
                                                        fullname: fullname)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(.blue)
                .clipShape(.buttonBorder)
                .padding(.top, 24)
                
                Spacer()
                
            }
            
            // go back to login view
            
            Button {
                dismiss()
            } label: {
                HStack  {
                    Text("Already have an account ?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
    }
}

#Preview {
    RegistrationView()
}
