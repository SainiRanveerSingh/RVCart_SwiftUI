//
//  LoginViewModel.swift
//  RVCart
//
//  Created by RV on 03/06/25.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var isInvalidUser = false
    @Published var isLoading: Bool = false
    
    var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: emailText)
    }
    
    func login(completion: @escaping ((String?) -> Void)) {
        guard !emailText.isEmpty, !passwordText.isEmpty else {
            errorMessage = ErrorMessages.requiredError
            self.isInvalidUser = true
            return
        }
        
        guard isEmailValid else {
            errorMessage = ErrorMessages.validMail
            self.isInvalidUser = true
            return
        }
        
        isLoading = true
        
    }
    
}
