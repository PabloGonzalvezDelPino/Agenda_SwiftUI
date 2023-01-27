//
//  NewEventView.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//

import SwiftUI

struct NewEventView: View {
    @State var dateSelected: Date = Date()
    @State var title: String = ""
    @Binding var shouldShowNewEvent: Bool
    var completion: () -> () = {}
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            BackgroundColorView()
            VStack(spacing:30){
                Text("Create Event")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, 20)
                
                DatePicker("", selection: $dateSelected, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                
                TextField("Title", text: $title)
                    .frame(height: 44)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.horizontal, 31)
                
                Button {
                    postEvent()
                } label: {
                    Text("Add Event")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color("DarkGreen"))
                        .cornerRadius(20)
                        .padding(.horizontal, 100)
                    
                }
                
            }
            
        }
    }
    func newEvent(name: String, date: Int) {
        
        let url = "https://superapi.netlify.app/api/db/eventos"
        let dictionary: [String: Any] = [
            "name" : name,
            "date" : date
        ]
        
        NetworkHelper.shared.requestProvider(url: url, params: dictionary) { data, response, error in
            if let error = error {
                onError(error: error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    onSuccess()
                } else {
                    onError(error: error?.localizedDescription ?? "Request Error")
                }
            }
        }
    }
    
    func postEvent() {
        let dateConverted = convertDateToInt(date: dateSelected)
        newEvent(name: title, date: dateConverted)
    }
    
    func convertDateToInt(date: Date) -> Int {
        return Int(date.timeIntervalSince1970 * 1000)
    }
    
    func onSuccess() {
        completion()
        shouldShowNewEvent = false
    }
    func onError(error: String) {
        print(error)
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(shouldShowNewEvent: .constant(true))
    }
}
