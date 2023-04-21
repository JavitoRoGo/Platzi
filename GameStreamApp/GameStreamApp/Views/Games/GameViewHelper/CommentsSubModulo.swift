//
//  CommentsSubModulo.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 31/3/23.
//

import SwiftUI

struct CommentsSubModulo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("COMENTARIOS")
                .font(.title2)
                .foregroundColor(.white)
                .padding(.leading)
            
            VStack {
                HStack(alignment: .center) {
                    Image("perfilEjemplo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .padding(.leading)
                    VStack (alignment: .leading) {
                        Text("Enrique Ramos")
                            .fontWeight(.bold)
                        Text("Hace 7 días")
                            .font(.subheadline).padding(.bottom)
                    }
                    .foregroundColor(.white)
                    .padding(.leading)
                    
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.horizontal, 7)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("blueGray"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.all, 10)
        }
    }
}

struct CommentsSubModulo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            CommentsSubModulo()
        }
    }
}
