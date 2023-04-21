//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD
import UIKit


// Crear un color para el botón verde en modo oscuro
extension UIColor {
    static let customGreen: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor { trait in
                if trait.userInterfaceStyle == .dark {
                    // estamos en modo oscuro
                    return .white
                } else {
                    // estamos en modo claro
                    return .green
                }
            }
        } else {
            // menor que iOS 13.0
            return .green
        }
    }()
}



class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonAction() {
        view.endEditing(true) // para ocultar el teclado
        performLogin()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
        
        // Modo oscuro, disponible solo a partir de iOS 13
        if #available(iOS 13.0, *) {
            // Que esta página se muestre siempre en modo claro
            // Pero en realidad no se recomienda esta opción porque puede dar problemas
//            overrideUserInterfaceStyle = .light
        }
        
        loginButton.backgroundColor = .customGreen
    }
    
    private func performLogin() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo válido.", style: .warning).show()
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña.", style: .warning).show()
            return
        }
        
        // Iniciar sesión
        //Crear request
        let request = LoginRequest(email: email, password: password)
        //Iniciamos la carga
        SVProgressHUD.show()
        //Llamar a librería de red
        SN.post(endpoint: Endpoints.login, model: request) { (response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
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
        
        // El servicio del curso no responde, así que accedo directamente a la vista de tweets para poder usar la app:
        performSegue(withIdentifier: "showHome", sender: nil)
    }
}
