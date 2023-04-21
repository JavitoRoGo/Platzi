//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import AVKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutles
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "TweetTableViewCell"
    private var dataSource = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPosts()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    private func getPosts() {
        // Indicar carga al usuario
        SVProgressHUD.show()
        
        // Consumir el servicio
        SN.get(endpoint: Endpoints.getPosts) { (result: SNResultWithEntity<[Post], ErrorResponse>) in
            // Cerramos indicador de carga
            SVProgressHUD.dismiss()
            
            switch result {
            case .success(let posts):
                self.dataSource = posts
                self.tableView.reloadData()
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: "Algo ha ido mal: \(error.localizedDescription).", style: .danger).show()
                print(error.localizedDescription)
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: "Algo ha fallado: \(entity.error).", style: .warning).show()
            }
        }
    }
    
    private func deletePostAt(indexPath: IndexPath) {
        // Indicar carga al usuario
        SVProgressHUD.show()
        
        // Obtener ID del post a borrar
        let postID = dataSource[indexPath.row].id
        
        // Consumir servicio para borrar
        let endpoint = Endpoints.delete + postID
        SN.delete(endpoint: endpoint) { (result: SNResultWithEntity<GeneralResponse, ErrorResponse>) in
            // Cerramos indicador de carga
            SVProgressHUD.dismiss()
            
            switch result {
            case .success:
                // Borrar post del dataSource
                self.dataSource.remove(at: indexPath.row)
                // Borrar la celda de la tabla
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: "Algo ha ido mal: \(error.localizedDescription).", style: .danger).show()
                print(error.localizedDescription)
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: "Algo ha fallado: \(entity.error).", style: .warning).show()
            }
        }
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if let cell = cell as? TweetTableViewCell {
            cell.setupCellWith(post: dataSource[indexPath.row])
            cell.needsToShowVideo = { url in
                let avPlayer = AVPlayer(url: url)
                let avPlayerController = AVPlayerViewController()
                avPlayerController.player = avPlayer
                self.present(avPlayerController, animated: true) {
                    avPlayerController.player?.play()
                }
            }
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Borrar") { _, _ in
            // Borrar el tweet
            self.deletePostAt(indexPath: indexPath)
        }
        
        return [deleteAction]
    }
    
    // Método para que no permita borrar los posts de otros usuarios
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Obtener email logueado
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        
        return dataSource[indexPath.row].author.email != email
    }
}

// MARK: - NAVIGATION

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Validar que el segue sea el correcto
        if segue.identifier == "showMap", let mapViewController = segue.destination as? MapViewController {
            mapViewController.posts = dataSource.filter {
                $0.hasLocation // solo los que tengan localización
            }
        }
    }
}
