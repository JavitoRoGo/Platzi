//
//  HomeView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 28/3/23.
//

import SwiftUI

struct HomeView: View {
    @State var tabSeleccionado = 2
    
    var body: some View {
        TabView(selection: $tabSeleccionado) {
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
                .tag(0)
            
            GamesView()
                .tabItem {
                    Label("Juegos", systemImage: "gamecontroller")
                }
                .tag(1)
            
            PantallaHome()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .tag(2)
            
            FavoritesView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }
                .tag(3)
        }
        .accentColor(.white)
    }
    
    init() {
        // Para cambiar el color de fondo y el color de los símbolos de la tabBar
        // Se hace con propiedades de UIKit
        UITabBar.appearance().backgroundColor = UIColor(Color("tabBarColor"))
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().isTranslucent = true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
