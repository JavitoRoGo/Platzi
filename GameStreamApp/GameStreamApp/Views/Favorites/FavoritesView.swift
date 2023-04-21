//
//  FavoritesView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import AVKit
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var allGames = ViewModel()
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VStack {
                Text("FAVORITOS")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.bottom, 9)
                
                ScrollView {
                    ForEach(allGames.gamesInfo, id: \.self) { game in
                        VStack(spacing: 0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!))
                                .frame(height: 300)
                            Text(game.title)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("blueGray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                    }
                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 6)
        }
        .toolbar(.hidden)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
