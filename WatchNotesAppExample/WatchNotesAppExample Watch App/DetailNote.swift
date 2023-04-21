//
//  DetailNote.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 5/4/23.
//

import SwiftUI

struct DetailNote: View {
    let note: NoteModel
    
    var body: some View {
        VStack {
            Text(note.title)
                .font(.title3)
                .foregroundColor(.orange)
            Spacer()
            Text(note.date)
                .font(.footnote.bold())
                .foregroundColor(.gray)
        }
    }
}

struct DetailNote_Previews: PreviewProvider {
    static var previews: some View {
        DetailNote(note: NoteModel(title: "prueba"))
    }
}
