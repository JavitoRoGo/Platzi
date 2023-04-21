//
//  SubModuloHomePopulares.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 29/3/23.
//

import AVKit
import SwiftUI

let urlVideos:[String] = [
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256671638/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256720061/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256814567/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256705156/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256801252/movie480.mp4",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/256757119/movie480.mp4"
]

struct SubModuloHomePopulares: View {
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    
    var body: some View {
        VStack {
            Text("LOS MÁS POPULARES")
                .font(.title3.bold())
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ZStack {
                Button {
                    url = urlVideos[0]
                    isPlayerActive = true
                } label: {
                    VStack(spacing: 0) {
                        Image("The Witcher 3")
                            .resizable()
                            .scaledToFit()
                        Text("The Witcher 3")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .background(Color("blueGray"))
                    }
                }
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical)
        }
        
        NavigationLink(value: "player") {
            EmptyView()
        }
        .navigationDestination(isPresented: $isPlayerActive) {
            let player = AVPlayer(url: URL(string: url)!)
            VideoPlayer(player: player)
                .frame(width: 400, height: 300)
                .onDisappear { player.pause() }
        }
    }
}

struct SubModuloHome_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            SubModuloHomePopulares()
        }
    }
}
