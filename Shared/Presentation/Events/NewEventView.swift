//
//  NewEventView.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//

import SwiftUI

struct NewEventView: View {
    
    //MARK: Var Declarations
    
    @State var dateSelected: Date = Date()
    @State var title: String = ""
    @Binding var shouldShowNewEvent: Bool
    var completion: () -> () = {}
    @ObservedObject var viewmodel : ViewModel = ViewModel()
    
    //MARK: Body
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
                    viewmodel.postEvent(title: title, date: dateSelected)
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
        //MARK: Call to onSuccess
        }.onReceive(viewmodel.$onSuccessBool) { newValue in
            if newValue {
                completion()
                shouldShowNewEvent = false
            }
        }
    }
}
//MARK: Preview
struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(shouldShowNewEvent: .constant(true))
    }
}
