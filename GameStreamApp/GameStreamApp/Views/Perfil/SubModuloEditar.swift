//
//  SubModuloEditar.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import SwiftUI

struct SubModuloEditar: View {
    @State var email = ""
    @State var password = ""
    @State var userName = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Correo electrónico*")
                .font(.title2.bold())
                .foregroundColor(Color("darkCian"))
                .frame(width: 300, alignment: .leading)
            TextField(text: $email) {
                Text(verbatim: "ejemplo@ejemplo.com")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .font(.caption)
            .foregroundColor(.white)
            Divider()
                .frame(height: 1)
                .background(Color("darkCian"))
                .padding(.bottom, 32)
            
            Text("Contraseña*")
                .font(.title2.bold())
                .foregroundColor(.white)
            SecureField(text: $password) {
                Text("Introduce tu contraseña")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .font(.caption)
            .foregroundColor(.white)
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .padding(.bottom, 32)
            
            Text("Nombre de usuario*")
                .font(.title2.bold())
                .foregroundColor(.white)
            TextField(text: $userName) {
                Text("Introduce tu nombre de usuario")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .font(.caption)
            .foregroundColor(.white)
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .padding(.bottom)
            
            Button {
                updateData()
            } label: {
                Text("ACTUALIZAR DATOS")
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
            .padding(.top, 32)
        }
        .padding(.horizontal, 42)
    }
    
    func updateData() {
        let updaterObject = SaveData()
        let result = updaterObject.saveData(email: email, password: password, userName: userName)
        print("¿Se guardaron los datos? \(result)")
    }
}

struct SubModuloEditar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            SubModuloEditar()
        }
    }
}
