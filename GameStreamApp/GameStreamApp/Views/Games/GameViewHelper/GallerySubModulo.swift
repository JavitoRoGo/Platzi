//
//  GallerySubModulo.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 31/3/23.
//

import SwiftUI

struct GallerySubModulo: View {
    let imagesUrl: [String]
    let formaGrid = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("GALERÍA")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.leading)
            ScrollView(.horizontal) {
                LazyHGrid(rows: formaGrid, spacing: 8) {
                    ForEach(imagesUrl, id:\.self) { imgUrl in
                        let url = URL(string: imgUrl)!
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                        } placeholder: {
                            ProgressView()
                        }

                    }
                }
            }
            .frame(height: 180)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
    }
}

struct GallerySubModulo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            GallerySubModulo(imagesUrl: Game.example.galleryImages)
        }
    }
}
