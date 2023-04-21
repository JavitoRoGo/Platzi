//
//  ViewController.swift
//  ServiciosWebYAlamofire
//
//  Created by Javier Rodríguez Gómez on 18/3/23.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchService()
    }
    
    private func fetchService() {
        let endpointString = "http://www.mocky.io/v2/5e2674472f00002800a4f417"
        guard let endpoint = URL(string: endpointString) else { return }
        
        activityIndicator.startAnimating()
        
        
        // MARK: - Llamando a un servicio con URLSESSION
        /*
        // Endpoint: http://www.mocky.io/v2/5e2674472f00002800a4f417
        // 1. Crear expeción de seguridad, porque iOS solo permite conectar a dominios https. Se hace en info.plist
        // 2. Crear URL con el endpoint
        // 3. Hacer request con la ayuda de URLSession
        // 4. Transformar respuesta a diccionario
        // 5. Ejecutar Request
        
        URLSession.shared.dataTask(with: endpoint) { data, _, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if error != nil {
                // Hay algún error
                print(error!.localizedDescription)
                return
            }
            guard let data,
                  let model = try? JSONDecoder().decode(Human.self, from: data) else { return }
            
            // Los cambios en la UI deben hacerse siempre en el hilo principal:
            DispatchQueue.main.async {
                self.nameLabel.text = model.user
                self.statusLabel.text = model.isHappy ? "Es feliz" : "Es triste"
            }
        }.resume()
         */
        
        // MARK: - Llamando a un servicio con ALAMOFIRE
        AF.request(endpoint, method: .get).responseData { response in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if response.error != nil {
                // Hay algún error
                print(response.error!.localizedDescription)
                return
            }
            guard let data = response.data,
                  let model = try? JSONDecoder().decode(Human.self, from: data) else { return }
            
            // Los cambios en la UI deben hacerse siempre en el hilo principal:
            DispatchQueue.main.async {
                self.nameLabel.text = model.user
                self.statusLabel.text = model.isHappy ? "Es feliz" : "Es triste"
            }
        }
    }
}


struct Human: Codable {
    let user: String
    let age: Int
    let isHappy: Bool
}
