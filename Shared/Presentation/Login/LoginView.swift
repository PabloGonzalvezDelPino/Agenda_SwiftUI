//
//  LoginView.swift
//  Agenda_Pablo_Gonzalvez
//
//  Created by Apps2T on 23/1/23.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @State private var email: String = ""
    @State private var pass: String = ""
    @State public var shouldShowRegister: Bool = false
    @ObservedObject var viewmodel : ViewModel = ViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundColorView()
                
                VStack {
                    TitleView(title: "Login")
                    Spacer()
                    Image("calendar_pic")
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    textFields()
                    Spacer()
                    loginButton(title: "Login")
                    goToRegister()
                    
                }
            }
        }
    }
    
    // MARK: - Accessory Views
    func textFields() -> some View {
        VStack(spacing: 20) {
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
            
        }
    }
    func goToRegister() -> some View{
        HStack {
            Text("Haven't got an account yet?")
                .foregroundColor(.black)
                .font(.system(size: 17))
                .padding(.leading, 40)
            
            Spacer()
            
            Button {
                shouldShowRegister = true
            } label: {
                Text("Register").foregroundColor(.white)
                    .font(.system(size: 20))
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .background(Color("MediumGreen"))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .background(
                NavigationLink(destination: RegisterView(), isActive: $shouldShowRegister) {
                    EmptyView()
                }
            )
        }
        .padding(21)
    }
    func loginButton(title: String) -> some View {
        Button {
            viewmodel.login(email: email, pass: pass)
        } label: {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 30))
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color("DarkGreen"))
                .cornerRadius(20)
                .padding(.horizontal, 100)
            
        }
        .background(
            NavigationLink(destination: AgendaView(), isActive: $viewmodel.shouldShowAgenda) {
                EmptyView()
            }
        )
    }
    
}

//MARK: - Preview

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}





