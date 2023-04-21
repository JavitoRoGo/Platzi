//
//  NoteModel.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 4/4/23.
//

import SwiftUI

struct NoteModel: Identifiable, Codable {
    let id: UUID
    let title: String
    let date: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        self.date = formatter.string(from: date)
    }
}
