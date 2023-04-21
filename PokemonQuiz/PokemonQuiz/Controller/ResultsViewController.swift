//
//  ResultsViewController.swift
//  PokemonQuiz
//
//  Created by Javier Rodríguez Gómez on 13/3/23.
//

import Kingfisher
import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var pokemonName: String = ""
    var pokemonImageURL: String = ""
    var finalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Perdiste, tu puntuación fue de \(finalScore)"
        pokemonLabel.text = "No, es un \(pokemonName)"
        pokemonImage.kf.setImage(with: URL(string: pokemonImageURL))
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
