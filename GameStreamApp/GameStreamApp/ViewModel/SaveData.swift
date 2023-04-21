//
//  SaveData.swift
//  GameStreamApp
//
//  Created by Javier Rodríguez Gómez on 2/4/23.
//

import Foundation

class SaveData {
    private let saveKey = "datosUsuario"
    
    var email = ""
    var password = ""
    var nameUser = ""
    
    func saveData(email: String, password: String, userName: String = "") -> Bool {
        UserDefaults.standard.set([email, password, userName], forKey: saveKey)
        return true
    }
    
    func getData() -> [String] {
        guard let userData = UserDefaults.standard.stringArray(forKey: saveKey) else { return [] }
        return userData
    }
    
    func validateData(email: String, password: String) -> Bool {
        var savedEmail = ""
        var savedPassword = ""
        
        if UserDefaults.standard.object(forKey: saveKey) != nil {
            savedEmail = UserDefaults.standard.stringArray(forKey: saveKey)![0]
            savedPassword = UserDefaults.standard.stringArray(forKey: saveKey)![1]
            
            if email == savedEmail && password == savedPassword {
                return true
            } else {
                return false
            }
        }
        
        return false
    }
}
