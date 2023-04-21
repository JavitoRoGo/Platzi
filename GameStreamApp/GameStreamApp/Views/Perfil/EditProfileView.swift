//
//  EditProfileView.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import SwiftUI

struct EditProfileView: View {
    @State var imagenPerfil: Image? = Image("perfilEjemplo")
    @State var isCameraActive = false
    
    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Button {
                        isCameraActive = true
                    } label: {
                        ZStack {
                            imagenPerfil!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                                .clipShape(Circle())
                                .sheet(isPresented: $isCameraActive) {
                                    SUImagePickerView(sourceType: .photoLibrary, image: $imagenPerfil, isPresented: $isCameraActive)
                                }
                            Image(systemName: "camera")
                                .font(.title)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding(.bottom, 90)
                    
                    SubModuloEditar()
                }
                .padding(.bottom, 18)
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
