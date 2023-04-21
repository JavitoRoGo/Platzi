//
//  ContentView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 28/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack {
                    Image("appLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.top)
                        .padding(.bottom, 42)
                        .offset(y: 10)
                    InicioYRegistroView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
