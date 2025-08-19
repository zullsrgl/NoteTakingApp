//
//  NoteDetailViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.08.2025.
//


final class NoteDetailViewModel{
    
    func deleteNote(note: Note){
        CoreDataManager.shared.deleteNote(note: note)
    }
    
}
