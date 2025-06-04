//
//  LoginView.swift
//  RVCart
//
//  Created by RV on 03/06/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showSignUpView = false
    @State private var showForgetPasswordView = false
    
    
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        NavigationStack {
            VStack {
                Spacer()
                Text("RV Cart")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(themeColor)
                VStack {
                    VStack(spacing: 16) {
                        
                        TextField("Email Address", text: $viewModel.emailText)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.top)
                        
                        SecureField("Password", text: $viewModel.passwordText)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        print("Forgot Password Tapped")
                        showForgetPasswordView = true
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.trailing)
                    
                    Button(action: {
                        print("Sign In Tapped with email: \(viewModel.emailText), password: \(viewModel.passwordText)")
                        Task {
                            await login()
                        }
                        //showChatView = true
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.all)
                    
                    
                    
                    HStack {
                        Text("Don't have an account?")
                        Button(action: {
                            print("Sign Up Tapped")
                            showSignUpView = true
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                        }
                    }
                    .font(.footnote)
                    .padding()
                }
                .cornerRadius(20) /// make the background rounded
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(themeColor, lineWidth: 1.5)
                )
                //.border(Color(themeUIColor.cgColor), width: 1.0)
                
                
                .padding(.all)
                
                Spacer()
                
                
            }
            .onAppear {
                
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
    
    func login() async {
        let response = await viewModel.userLogin()
        if response.status {
            print(response.message)
        } else {
            print(response.message)
        }
    }
}

#Preview {
    LoginView()
}
