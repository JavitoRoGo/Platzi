//
//  SearchGame.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 1/4/23.
//

import Foundation

class SearchGame: ObservableObject {
    @Published var gamesInfo = [Game]()
    
    func searchRequest(game: String, finished: @escaping (_ isSuccess: Bool) -> Void) {
        gamesInfo.removeAll()
        
        // la siguiente constante es para sustituir los espacios del nombre por %, porque la url no puede tener espacios
        let gameNameSpaces = game.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://gamestreamapi.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "cuphead")")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data {
                    let decoded = try JSONDecoder().decode(Resultados.self, from: data)
                    DispatchQueue.main.async {
                        self.gamesInfo = decoded.results
                        finished(true)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                    finished(false)
                }
            }
        }.resume() //OJO no olvidar poner este resume
    }
}
