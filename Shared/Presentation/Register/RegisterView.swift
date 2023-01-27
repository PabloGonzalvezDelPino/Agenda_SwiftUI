//
//  RegisterView.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//

import SwiftUI

struct RegisterView: View {
    // MARK: - Properties
    
    @State private var email: String = ""
    @State private var pass: String = ""
    @State private var rePass: String = ""
    @ObservedObject var viewmodel : ViewModel = ViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            BackgroundColorView()
            VStack(spacing: 20) {
                TitleView(title: "Register")
                textFields()
                Spacer()
                registerButton()
                Spacer()
            }
        }
        .onReceive(viewmodel.$onSuccessBool) { newValue in
            if newValue {
                mode.wrappedValue.dismiss()
            }
        }
    }
    // MARK: - Accessory Views
    func textFields() -> some View {
        VStack(spacing: 20){
            TextField("Email", text: $email)
                .frame(height: 44)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal, 21)
            
            SecureField("Password", text: $pass)
                .frame(height: 44)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal, 21)
            
            SecureField("Repeat Password", text: $rePass)
                .frame(height: 44)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal, 21)
        }
    }
    func registerButton() -> some View {
        Button {
            if(pass == rePass){
                viewmodel.register(email: email, pass: pass)
            }else{
                
            }
        } label: {
            Text("Register").foregroundColor(.white)
                .font(.system(size: 30))
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color("DarkGreen"))
                .cornerRadius(20)
                .padding(.horizontal, 100)
        }
    }
}


// MARK: - Previews

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
