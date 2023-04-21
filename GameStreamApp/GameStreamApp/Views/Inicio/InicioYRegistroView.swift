//
//  InicioYRegistroView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 28/3/23.
//

import SwiftUI

struct InicioYRegistroView: View {
    @State var tipoInicioSesion = true
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("INICIA SESIÓN") {
                    tipoInicioSesion = true
                }
                .foregroundColor(tipoInicioSesion ? .white : .gray)
                Spacer()
                Button("REGÍSTRATE") {
                    tipoInicioSesion = false
                }
                .foregroundColor(tipoInicioSesion ? .gray : .white)
                Spacer()
            }
            
            Spacer(minLength: 42)
            if tipoInicioSesion {
                // Inicio sesión
                InicioSesionView()
            } else {
                // Pantalla registro
                RegistroView()
            }
        }
    }
}

struct InicioYRegistroView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            InicioYRegistroView()
        }
    }
}
