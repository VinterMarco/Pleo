//
//  LoginView.swift
//  Pleo
//
//  Created by Vinter Marco on 17.12.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack {

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
                        text: $password,
                        title: "Password",
                        placeholder: "Enter your password",
                        isSecureField: true)
                    .autocapitalization(.none)
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                // sign in btn
                
                Button {
                    print("Log in user in ... ")
                } label: {
                    HStack {
                        Text("SIGN IN")
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
                // sign up btn
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack (spacing : 5) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
