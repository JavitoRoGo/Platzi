//
//  SubModuloHomeGustar.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 1/4/23.
//

import AVKit
import SwiftUI

struct SubModuloHomeGustar: View {
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    
    var body: some View {
        VStack {
            Text("VÍDEOS QUE PODRÍAN GUSTARTE")
                .font(.title3.bold())
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button {
                        url = urlVideos[4]
                        isPlayerActive = true
                    } label: {
                        Image("Cuphead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    Button {
                        url = urlVideos[5]
                        isPlayerActive = true
                    } label: {
                        Image("Hades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    Button {
                        url = urlVideos[6]
                        isPlayerActive = true
                    } label: {
                        Image("Grand Theft Auto V")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
        }
        
        NavigationLink(value: "player") {
            EmptyView()
        }
        .navigationDestination(isPresented: $isPlayerActive) {
            VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                .frame(width: 400, height: 300)
        }
    }
}

struct SubModuloHomeGustar_Previews: PreviewProvider {
    static var previews: some View {
        SubModuloHomeGustar()
    }
}
