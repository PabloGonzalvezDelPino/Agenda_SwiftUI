//
//  NewEventView-ViewModel.swift
//  Agenda_Pablo_Gonzalvez (iOS)
//
//  Created by Apps2T on 27/1/23.
//

import Foundation

extension NewEventView {
        class ViewModel: ObservableObject {
            
            @Published var onSuccessBool: Bool = false
    
            func newEvent(name: String, date: Int) {
    
                let url = "https://superapi.netlify.app/api/db/eventos"
                let dictionary: [String: Any] = [
                    "name" : name,
                    "date" : date
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
    
            func postEvent(title: String, date: Date) {
                let dateConverted = convertDateToInt(date: date)
                newEvent(name: title, date: dateConverted)
    
            }
    
            func convertDateToInt(date: Date) -> Int {
                return Int(date.timeIntervalSince1970 * 1000)
            }
    
            func onSuccess() {
                onSuccessBool = true
            }
            func onError(error: String) {
                print(error)
            }
        }
}
