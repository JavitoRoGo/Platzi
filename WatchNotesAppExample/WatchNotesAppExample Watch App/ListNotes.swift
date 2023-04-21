//
//  ListNotes.swift
//  WatchNotesAppExample Watch App
//
//  Created by Javier Rodríguez Gómez on 5/4/23.
//

import SwiftUI

struct ListNotes: View {
    @State private var notes: [NoteModel] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: DetailNote(note: note)) {
                        Text("\(note.title) - \(note.date)")
                            .lineLimit(1)
                    }
                }
                .onDelete(perform: deleteNote)
            }
        }
        .onAppear {
            notes = ViewModel.shared.loadData()
        }
    }
    
    func deleteNote(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
        ViewModel.shared.saveData(notes: notes)
    }
}

struct ListNotes_Previews: PreviewProvider {
    static var previews: some View {
        ListNotes()
    }
}
