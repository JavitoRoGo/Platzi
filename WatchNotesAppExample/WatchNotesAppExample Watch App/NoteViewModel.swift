//
//  NoteViewModel.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 5/4/23.
//

import Foundation

final class ViewModel {
    // Estas dos primeras líneas no las entiendo pero son para iniciar la clase y usarla en cada vista sin tener que crear instancias todo el rato
    // No sé porqué no usa ObservableObject
    static let shared = ViewModel()
    private init() { }
    
    let keyForUD = "NotesApp"
    
    func saveData(notes: [NoteModel]) {
        let data = notes.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: keyForUD)
    }
    
    func loadData() -> [NoteModel] {
        guard let savedData = UserDefaults.standard.array(forKey: keyForUD) as? [Data] else { return [] }
        return savedData.map { try! JSONDecoder().decode(NoteModel.self, from: $0) }
    }
}
