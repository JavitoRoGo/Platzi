//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD
import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var namesTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func registerButtonAction() {
        view.endEditing(true)
        performRegister()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        registerButton.layer.cornerRadius = 25
    }
    
    private func performRegister() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo válido.", style: .warning).show()
            return
        }
        
        guard let names = namesTextField.text, !names.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar tu nombre y apellido.", style: .warning).show()
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña.", style: .warning).show()
            return
        }
        
        // Hacer registro
        //Crear request
        let request = RegisterRequest(email: email, password: password, names: names)
        //Indicar la carga al usuario
        SVProgressHUD.show()
        //Llamar al servicio
        SN.post(endpoint: Endpoints.register, model: request) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let user):
                NotificationBanner(subtitle: "Bienvenido \(user.user.names)", style: .success).show()
                // Guardar email para comprobación en borrado de tweets
                UserDefaults.standard.set(user.user.email, forKey: "email")
                
                self.performSegue(withIdentifier: "showHome", sender: nil)
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: user.token)
            case .error(let error):
                NotificationBanner(title: "Error", subtitle: "Algo ha ido mal: \(error.localizedDescription).", style: .danger).show()
                print(error.localizedDescription)
            case .errorResult(let entity):
                NotificationBanner(title: "Error", subtitle: "Algo ha fallado: \(entity.error).", style: .warning).show()
            }
        }
    }
}
