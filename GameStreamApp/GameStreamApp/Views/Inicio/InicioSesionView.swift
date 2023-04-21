//
//  InicioSesionView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 28/3/23.
//

import SwiftUI

struct InicioSesionView: View {
    @State var email = ""
    @State var password = ""
    @State var isHomeActive = false
    @State var showingWrongDataAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Correo electrónico")
                    .foregroundColor(Color("darkCian"))
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
                
                Text("Contraseña")
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
                
                Text("¿Olvidaste tu constraseña?")
                    .font(.footnote)
                    .foregroundColor(Color("darkCian"))
                    .frame(width: 300, alignment: .trailing)
                    .padding(.bottom)
                
                Button {
                    iniciarSesion()
                } label: {
                    Text("INICIAR SESIÓN")
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
                
                Text("Inicia sesión con redes sociales")
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
            .padding(.horizontal, 77)
            
            NavigationLink(value: "home") {
                EmptyView()
            }
            .navigationDestination(isPresented: $isHomeActive) {
                HomeView()
            }
        }
        .alert("Error de autenticación", isPresented: $showingWrongDataAlert) {
            Button("Reintentar", role: .cancel) { }
        } message: {
            Text("El usuario o la contraseña introducidos no son correctos.\nRegístrate si aun no lo has hecho o vuelve a intentarlo.")
        }
    }
    
    func iniciarSesion() {
        isHomeActive = true
        /*
        Código comentado para que inicie sesión directamente y hacer las pruebas más rápido
        let savedData = SaveData()
        if savedData.validateData(email: email, password: password) {
            isHomeActive = true
        } else {
            showingWrongDataAlert = true
        }
         */
    }
}

struct InicioSesionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            InicioSesionView()
        }
    }
}
