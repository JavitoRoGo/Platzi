//
//  AddNote.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 4/4/23.
//

import SwiftUI

struct AddNote: View {
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State private var notes = [NoteModel]()
    
    var body: some View {
        VStack {
            TextField("nota", text: $text)
            Button("Agregar nota") {
                if !text.isEmpty {
                    let note = NoteModel(title: text)
                    notes.append(note)
                    ViewModel.shared.saveData(notes: notes)
                    text = ""
                    dismiss()
                }
            }
        }
        .onAppear {
            notes = ViewModel.shared.loadData()
        }
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
