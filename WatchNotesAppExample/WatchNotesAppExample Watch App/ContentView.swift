//
//  ContentView.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.orange.opacity(0.85)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink {
                        AddNote()
                    } label: {
                        Text("Agregar nota")
                    }
                    NavigationLink("Listar notas", destination: ListNotes())
                }
            }
            .navigationTitle("Notas")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
