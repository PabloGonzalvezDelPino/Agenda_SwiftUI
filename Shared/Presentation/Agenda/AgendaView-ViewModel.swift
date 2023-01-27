//
//  AgendaView-ViewModel.swift
//  Agenda_Pablo_Gonzalvez (iOS)
//
//  Created by Apps2T on 26/1/23.
//

import Foundation
extension AgendaView {
    // MARK: - Login Request
    class ViewModel: ObservableObject {
        
        @Published var events: [EventPresentationModel] = []
        func getEvents() {
            let url = "https://superapi.netlify.app/api/db/eventos"
            NetworkHelper.shared.requestProvider(url: url, type: .GET) { data, response, error in
                if let error = error {
                    self.onError(error: error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        self.onSuccess(data: data)
                    } else {
                        self.onError(error: error?.localizedDescription ?? "Request Error")
                    }
                }
            }
        }
        
        
        func onSuccess(data: Data) {
            do {
                let eventsNotFiltered = try JSONDecoder().decode([EventResponseModel?].self, from: data)
                
                self.events = eventsNotFiltered.compactMap({ eventNotFiltered in
                    guard let date = eventNotFiltered?.date else { return nil }
                    var eventSelected = EventPresentationModel(name: eventNotFiltered?.name ?? "Empty Name", date: date)
                    return eventSelected
                })
            } catch {
                self.onError(error: error.localizedDescription)
            }
            
        }
        
        func onError(error: String) {
            print(error)
        }
        func transformDate(date:Int) -> String{
            let date = NSDate(timeIntervalSince1970: TimeInterval(date / 1000))
            
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "dd MMM YY"
            
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            return dateString
        }
        
    }
}
