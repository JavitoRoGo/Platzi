//
//  Model.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 30/3/23.
//

import Foundation

struct Resultados: Codable {
    // Este modelo se usará para los resultados de la búsqueda
    let results: [Game]
}

struct Game: Codable, Hashable {
    let title, studio, contentRaiting, publicationYear, description: String
    let platforms, tags: [String]
    let videosUrls: VideosUrls
    let galleryImages: [String]
    
    static let example = Game(title:"Sonic The Hedgehog", studio: "Sega", contentRaiting: "E+", publicationYear: "1991", description: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", platforms: ["plataformas"], tags:["plataformas","mascota"], videosUrls: VideosUrls(mobile: "mobile", tablet: "tablet"), galleryImages: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
}

struct VideosUrls: Codable, Hashable {
    let mobile, tablet: String
}
