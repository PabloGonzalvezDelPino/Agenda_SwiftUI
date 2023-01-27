//
//  RegisterView-ViewModel.swift
//  Agenda_Pablo_Gonzalvez (iOS)
//
//  Created by Apps2T on 26/1/23.
//

import Foundation
extension RegisterView {
    // MARK: - Login Request
    class ViewModel: ObservableObject {
        @Published var onSuccessBool: Bool = false
        // MARK: - Private Methods
        func register(email: String, pass: String) {
            
            let url = "https://superapi.netlify.app/api/register"
            let dictionary: [String: Any] = [
                "user" : email,
                "pass" : pass
            ]
            
            NetworkHelper.shared.requestProvider(url: url, params: dictionary) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        self.onSuccess()
                    } else {
                        self.onError(error: error?.localizedDescription ?? "Request Error")
                    }
                }
            }
        }
        
        func onSuccess() {
            onSuccessBool = true
            //mode.wrappedValue.dismiss()
        }
        
        func onError(error: String) {
            print(error)
        }
        
    }
}
