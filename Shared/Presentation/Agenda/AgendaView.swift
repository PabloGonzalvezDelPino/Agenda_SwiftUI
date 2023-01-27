//
//  AgendaView.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//
import SwiftUI

struct AgendaView: View {
    // MARK: - Properties
    @State var dateSelected: Date = Date()
    @State var shouldShowNewEvent = false
    @ObservedObject var viewmodel : ViewModel = ViewModel()
    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundColorView()
            
            VStack(spacing: 0) {
                
                tittleAndImage()
                eventsList()
            }
        }
        .sheet(isPresented: $shouldShowNewEvent, content: {
            NewEventView(shouldShowNewEvent: $shouldShowNewEvent) {
                viewmodel.getEvents()
            }
        })
        .toolbar {
            Button {
                shouldShowNewEvent = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .background(Color("DarkGreen"))
                    .cornerRadius(10)
            }
        }
        .onAppear {
            viewmodel.getEvents()
        }
        .onChange(of: dateSelected) { _ in
            let newDate = Int(dateSelected.timeIntervalSince1970)
        }
    }
    // MARK: - Accessory Views
    func tittleAndImage() -> some View {
        VStack(spacing: 20) {
            HStack{
                Spacer()
                Image("contrato")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.horizontal, 10)
                Text("Agenda")
                    .foregroundColor(.white)
                    .font(.system(size: 60, weight: .bold))
                    .padding(.top, 20)
                Spacer()
                
            }
        }
        .padding(.bottom, 5)
    }
    func eventsList() -> some View {
        ScrollView {
            LazyVStack(spacing: 1) {
                ForEach(viewmodel.events) { event in
                    HStack {
                        Text(event.name)
                        Spacer()
                        Text(viewmodel.transformDate(date: event.date))
                    }
                    .padding(.horizontal, 5)
                    .frame(height: 40)
                    .background(Color.white)
                    .padding(.horizontal, 10)
                }
            }
        }
        .padding(.bottom, 5)
    }
}
// MARK: - Preview
struct AgendaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaView()
    }
}
