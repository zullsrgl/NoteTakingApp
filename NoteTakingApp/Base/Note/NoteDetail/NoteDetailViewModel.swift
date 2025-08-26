//
//  NoteDetailViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 19.08.2025.
//

import CoreData

protocol NoteDetailViewModelDelegate: AnyObject {
    func noteArried(note: Note?)
}

final class NoteDetailViewModel{
    
    weak var delegate: NoteDetailViewModelDelegate?
    
    func deleteNote(note: NSManagedObjectID){
        CoreDataManager.shared.deleteNote(noteID: note)
    }
    
    func getNote(noteID: NSManagedObjectID){
        let note = CoreDataManager.shared.getNote(noteID: noteID)
        delegate?.noteArried(note: note)
    }
}
