//
//  RegistroView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 28/3/23.
//

import SwiftUI

struct RegistroView: View {
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State var showingRegistrationAlert = false
    @State var showingWrongAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Elije una foto de perfil")
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                Text("Puedes cambiar o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                Button {
                    tomarFoto()
                } label: {
                    ZStack {
                        Image("perfilEjemplo")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image(systemName: "camera")
                            .bold()
                            .foregroundColor(.white)
                    }
                }

            }
            .padding(.bottom, 35)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Correo electrónico*")
                        .foregroundColor(Color("darkCian"))
                        .frame(width: 300, alignment: .leading)
                    TextField(text: $email) {
                        Text(verbatim: "ejemplo@ejemplo.com")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    Divider()
                        .frame(height: 1)
                        .background(Color("darkCian"))
                        .padding(.bottom)
                    
                    Text("Contraseña*")
                        .foregroundColor(.white)
                    SecureField(text: $password) {
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    Divider()
                        .frame(height: 1)
                        .background(Color("darkCian"))
                        .padding(.bottom)
                    
                    Text("Repetir Contraseña*")
                        .foregroundColor(.white)
                    SecureField(text: $repeatPassword) {
                        Text("Repite tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    Divider()
                        .frame(height: 1)
                        .background(Color("darkCian"))
                        .padding(.bottom)
                }
                
                Button {
                    registrarse()
                } label: {
                    Text("REGÍSTRATE")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("darkCian"), lineWidth: 1)
                                .shadow(color: .white, radius: 6)
                        }
                }
                
                Text("Regístrate con redes sociales")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 45)
                    .padding(.bottom)
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Facebook")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color("blueGray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .padding()
                    Button {
                        
                    } label: {
                        Text("Twitter")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color("blueGray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 77)
        }
        .alert("¡Enhorabuena!", isPresented: $showingRegistrationAlert) {
            Button("Entendido") {
                email = ""
                password = ""
                repeatPassword = ""
            }
        } message: {
            Text("Te has registrado correctamente.\nInicia sesión con tus credenciales.")
        }
        .alert("¡Upsss!", isPresented: $showingWrongAlert) {
            Button("Reintentar", role: .cancel) { }
        } message: {
            Text("Algo ha ido mal con el registro. Revisa que no haya campos vacíos y que hayas escrito bien tu contraseña.")
        }
    }
    
    func registrarse() {
        if password == repeatPassword && (!email.isEmpty && !password.isEmpty) {
            let savedData = SaveData()
            let result = savedData.saveData(email: email, password: password)
            if result {
                showingRegistrationAlert = true
            } else {
                showingWrongAlert = true
            }
        } else {
            showingWrongAlert = true
        }
    }
    
    func tomarFoto() {
        
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            RegistroView()
        }
    }
}
