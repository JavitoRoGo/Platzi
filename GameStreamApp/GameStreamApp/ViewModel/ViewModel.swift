//
//  ViewModel.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 30/3/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var gamesInfo = [Game]()
    
    init() {
        let url = URL(string: "https://gamestreamapi.herokuapp.com/api/games")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Es recomendable gestionar el error
            // Y usar response para ver qué error puede haber
            do {
                if let data {
                    let decoded = try JSONDecoder().decode([Game].self, from: data)
                    DispatchQueue.main.async {
                        self.gamesInfo = decoded
                        // esta asignación de datos se hace de manera asíncrona para no bloquear la interfaz mientras se obtienen los datos
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume() //OJO no olvidar poner este resume
    }
}
