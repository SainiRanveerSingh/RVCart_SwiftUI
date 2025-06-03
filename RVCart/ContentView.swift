//
//  ContentView.swift
//  RVCart
//
//  Created by RV on 22/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToLogin = false
    @State private var navigateToHome = false
    //----
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                Text("RV Cart")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundStyle(Color(themeUIColor.cgColor))
                Spacer()
                NavigationLink(destination: LoginView()) {
                    
                }
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        navigateToLogin = true
                                    }
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
