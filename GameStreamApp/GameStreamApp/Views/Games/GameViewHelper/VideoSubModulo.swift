//
//  VideoSubModulo.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 31/3/23.
//

import AVKit
import SwiftUI

struct VideoSubModulo: View {
    let url: String
    
    var body: some View {
        let player = AVPlayer(url: URL(string: url)!)
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onDisappear{ player.pause() }
    }
}

struct VideoSubModulo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VideoSubModulo(url: Game.example.videosUrls.mobile)
        }
    }
}
