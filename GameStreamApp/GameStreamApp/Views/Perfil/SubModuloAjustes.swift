//
//  SubModuloAjustes.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import SwiftUI

struct SubModuloAjustes: View {
    @State var isToggleOn = true
    @State var showingEditProfile = false
    
    var body: some View {
        VStack(spacing: 4) {
            SettingButton(label: "Cuenta", rightModifier: Image(systemName: "chevron.right")) { }
            SettingButton(label: "Notificaciones", rightModifier: Toggle("", isOn: $isToggleOn)) { }
            SettingButton(label: "Editar perfil", rightModifier: Image(systemName: "chevron.right")) {
                showingEditProfile = true
            }
            SettingButton(label: "Califica esta app", rightModifier: Image(systemName: "chevron.right")) { }
        }
        NavigationLink(value: "editarPerfil") {
            EmptyView()
        }
        .navigationDestination(isPresented: $showingEditProfile) {
            EditProfileView()
        }
    }
}

struct SubModuloAjustes_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            SubModuloAjustes()
        }
    }
}


struct SettingButton<Content: View>: View {
    let label: String
    let rightModifier: Content
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(label)
                    .foregroundColor(.white)
                Spacer()
                rightModifier
                    .foregroundColor(.white)
            }
            .padding()
        }
        .background(Color("blueGray"))
        .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}
