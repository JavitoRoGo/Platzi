//
//  VideoInfoSubModulo.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 31/3/23.
//

import SwiftUI

struct VideoInfoSubModulo: View {
    let game: Game
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(game.title)
                    .font(.largeTitle)
                
                HStack {
                    Text(game.studio)
                    Text(game.contentRaiting)
                    Text(game.publicationYear)
                }
                .padding(.top, 5)
                
                Text(game.description)
                    .padding(.top, 5)
                
                HStack {
                    ForEach(game.tags, id: \.self) { tag in
                        Text("#\(tag)")
                            .padding(.top, 4)
                    }
                }
            }
            .font(.subheadline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            GallerySubModulo(imagesUrl: game.galleryImages)
            
            CommentsSubModulo()
        }
        .frame(maxWidth: .infinity)
    }
}

struct VideoInfoSubModulo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VideoInfoSubModulo(game: Game.example)
        }
    }
}
