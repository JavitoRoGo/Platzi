//
//  GamesView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 30/3/23.
//

import SwiftUI

struct GamesView: View {
    @ObservedObject var allGames = ViewModel()
    
    let formaGrid = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VStack {
                Text("Juegos")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 35, trailing: 0))
                ScrollView {
                    LazyVGrid(columns: formaGrid, spacing: 8) {
                        ForEach(allGames.gamesInfo, id: \.self) { game in
                            NavigationLink {
                                GameView(game: game)
                            } label: {
                                VStack {
                                    AsyncImage(url: URL(string: game.galleryImages[0])!) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .padding(.horizontal, 7)
                                    } placeholder: {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150, height: 150)
                                            .foregroundColor(.white)
                                    }
                                    Text("\(game.title)")
                                        .foregroundColor(.white)
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 6)
        }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
