//
//  Components.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//
import SwiftUI
import Foundation
// MARK: - Public Components

struct BackgroundColorView: View {
    var body: some View {
        Color("FreshGreen")
            .ignoresSafeArea()
    }
}
struct TitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .bold))
            .padding(.top, 20)
    }
    
}


