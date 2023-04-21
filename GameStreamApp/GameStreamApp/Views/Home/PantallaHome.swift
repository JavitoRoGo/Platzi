//
//  PantallaHome.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 29/3/23.
//

import SwiftUI

struct PantallaHome: View {
    @ObservedObject var searchModel = SearchGame()
    
    @State var textoBusqueda = ""
    @State var gameFound: Game = Game.example
    @State var showingGameView = false
    @State var isGameInfoEmpty = false
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            
            VStack {
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom, 7)
                HStack {
                    Button {
                        watchGame(name: textoBusqueda)
                    } label: {
                        Image(systemName: ("magnifyingglass"))
                            .foregroundColor(textoBusqueda.isEmpty ? .yellow : Color("darkCian"))
                    }
                    .alert("Error", isPresented: $isGameInfoEmpty) {
                        Button("Entendido") { }
                    } message: {
                        Text("No se encontró el juego")
                    }
                    TextField(text: $textoBusqueda) {
                        Text("Buscar un vídeo")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                    .autocorrectionDisabled()
                    .onSubmit { watchGame(name: textoBusqueda) }
                }
                .padding([.top, .leading, .bottom], 11)
                .background(Color("blueGray"))
                .clipShape(Capsule())
                
                ScrollView {
                    SubModuloHomePopulares()
                    
                    SubModuloHomeSugeridos()
                    
                    SubModuloHomeRecomendados()
                    
                    SubModuloHomeGustar()
                }
            }
            .padding(.horizontal, 18)
            
            NavigationLink(value: "gameView") {
                EmptyView()
            }
            .navigationDestination(isPresented: $showingGameView) {
                GameView(game: gameFound)
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
    
    func watchGame(name: String) {
        if textoBusqueda.isEmpty {
            isGameInfoEmpty = true
            return
        }
        searchModel.searchRequest(game: name) { finished in
            if finished {
                DispatchQueue.main.async {
                    print("Cantidad de encontrados: \(searchModel.gamesInfo.count)")
                    if searchModel.gamesInfo.isEmpty {
                        isGameInfoEmpty = true
                    } else {
                        gameFound = searchModel.gamesInfo[0]
                        showingGameView = true
                    }
                }
            }
        }
    }
}

struct PantallaHome_Previews: PreviewProvider {
    static var previews: some View {
        PantallaHome(gameFound: Game.example)
    }
}
