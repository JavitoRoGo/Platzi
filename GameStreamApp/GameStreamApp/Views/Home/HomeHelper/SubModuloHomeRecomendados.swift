//
//  SubModuloHomeRecomendados.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 30/3/23.
//

import AVKit
import SwiftUI

struct SubModuloHomeRecomendados: View {
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    
    var body: some View {
        VStack {
            Text("RECOMENDADOS PARA TI")
                .font(.title3.bold())
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button {
                        url = urlVideos[1]
                        isPlayerActive = true
                    } label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    Button {
                        url = urlVideos[2]
                        isPlayerActive = true
                    } label: {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    Button {
                        url = urlVideos[3]
                        isPlayerActive = true
                    } label: {
                        Image("DEATH STRANDING")
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

struct SubModuloHomeRecomendados_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            SubModuloHomeRecomendados()
        }
    }
}
