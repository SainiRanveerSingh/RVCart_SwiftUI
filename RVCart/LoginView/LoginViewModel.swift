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
    
    func userLogin() async -> ( responseData: LoginResponse,status: Bool,message: String ) {
        
        let loginData = LoginResponse(accessToken: "", refreshToken: "")
        guard !emailText.isEmpty, !passwordText.isEmpty else {
            errorMessage = ErrorMessages.requiredError
            self.isInvalidUser = true
            return (loginData, false, ErrorMessages.requiredError)
        }
        
        guard isEmailValid else {
            errorMessage = ErrorMessages.validMail
            self.isInvalidUser = true
            return (loginData, false, ErrorMessages.validMail)
        }
        
        isLoading = true
        let param = ["email": emailText, "password": passwordText]
        //TODO: Testing
        //let param = ["email": "john@mail.com", "password": "changeme"]
        let requestBody = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
        guard let requestUrl = URL(string: APPURL.Urls.Login) else
        {
            return (loginData, false, "Please try again.")
        }
        
         var request = URLRequest(url: requestUrl)
         
         request.httpMethod = "POST"
         request.httpBody = requestBody
         //Authorization: Bearer {your_access_token}
        /*
         if addAccessToken {
         let token = KeychainSecure.instance.getToken(forKey: "accessToken") ?? ""
         request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         }
        */
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
         
//        let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
//        let url = URL(string: APPURL.Urls.Login)!
        do {
            //let (data, _) = try await URLSession.shared.data(for: request)
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)//data(from: url)
            //--
            
            if let dataValue = try? JSONDecoder().decode(FailureResponse.self, from: data) {
                print(dataValue.message)
                return (loginData, false, ErrorMessages.responseErrorTryAgain)
            }
            else if let dataValue = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                print(dataValue.accessToken)
                return (dataValue, true, "Data Received")
            }
            //--
        }
        catch {
            return (loginData, false, ErrorMessages.responseErrorTryAgain)
        }
        return (loginData, false, ErrorMessages.responseErrorTryAgain)
    }
    
}
