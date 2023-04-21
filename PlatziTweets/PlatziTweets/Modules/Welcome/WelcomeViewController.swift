//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup the UI
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
}
