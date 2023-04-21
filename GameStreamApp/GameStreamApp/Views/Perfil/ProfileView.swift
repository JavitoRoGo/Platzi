//
//  ProfileView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import SwiftUI

struct ProfileView: View {
    @State var nombreUsuario = "Random"
    @State var imagenPerfil = UIImage(named: "perfilEjemplo")!
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            VStack {
                Text("Perfil")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                
                VStack {
                    Image(uiImage: imagenPerfil)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118, height: 118)
                        .clipShape(Circle())
                    Text(nombreUsuario)
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))
                
                Text("AJUSTES")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 18)
                
                SubModuloAjustes()
                
                Spacer()
            }
        }
        .onAppear {
            let savedDatas = SaveData()
            if !savedDatas.getData().isEmpty {
                nombreUsuario = savedDatas.getData()[2]
            }
            if let uiimage = returnUIImage(named: "fotoperfil") {
                imagenPerfil = uiimage
            }
        }
        .toolbar(.hidden)
    }
    
    func returnUIImage(named: String) -> UIImage? {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = directory.appendingPathComponent(named)
            if let data = try? Data(contentsOf: file) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
