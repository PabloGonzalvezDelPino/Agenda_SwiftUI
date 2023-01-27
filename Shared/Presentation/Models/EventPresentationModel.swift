//
//  EventPresentationModel.swift
//  Agenda_Pablo_Gonzalvez (iOS)
//
//  Created by Apps2T on 27/1/23.
//

import Foundation
struct EventPresentationModel: Identifiable {
    let id = UUID()
    let name: String
    let date: Int
}
