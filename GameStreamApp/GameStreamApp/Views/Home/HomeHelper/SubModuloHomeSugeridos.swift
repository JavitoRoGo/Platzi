//
//  SubModuloHomeSugeridos.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 30/3/23.
//

import SwiftUI

struct SubModuloHomeSugeridos: View {
    let device = UIDevice.current.model
    
    var body: some View {
        VStack {
            Text("CATEGORÍAS SUGERIDAS PARA TI")
                .font(.title3.bold())
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                if device == "iPad" {
                    HStack {
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 320, height: 180)
                                Image("FPS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                            }
                        }
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 320, height: 180)
                                Image("RPG")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                            }
                        }
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 320, height: 180)
                                Image("OpenWorld")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 84, height: 84)
                            }
                        }
                    }
                } else {
                    HStack {
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 160, height: 90)
                                Image("FPS")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 160, height: 90)
                                Image("RPG")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("blueGray"))
                                    .frame(width: 160, height: 90)
                                Image("OpenWorld")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 42, height: 42)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SubModuloHomeSugeridos_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            SubModuloHomeSugeridos()
        }
    }
}
