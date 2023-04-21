//
//  PokemonData.swift
//  PokemonQuiz
//
//  Created by Javier Rodríguez Gómez on 13/3/23.
//

import Foundation

// Datos en bruto recibidos de la API

// MARK: - PokemonData
struct PokemonData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}
