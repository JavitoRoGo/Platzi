//
//  GameView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 31/3/23.
//

import SwiftUI

struct GameView: View {
    let game: Game
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VStack {
                VideoSubModulo(url: game.videosUrls.mobile)
                    .frame(height: 300)
                
                VideoInfoSubModulo(game: game)
                    .padding(.bottom)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game.example)
    }
}
