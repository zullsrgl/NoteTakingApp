//
//  NoteViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 29.07.2025.
//

import CoreData

protocol NoteViewModelDelegate: AnyObject {
    func fectedAllCategories(categories: [Category])
    func getNote(note: Note)
}

final class CreateNoteViewModel {
    
    weak var delegate: NoteViewModelDelegate?
    
    func fetchAllCategories(){
        let categories = CoreDataManager.shared.fetchAllCategories()
        delegate?.fectedAllCategories(categories: categories)
    }
    
    func deleteCategory(category: Category){
        CoreDataManager.shared.deleteCategory(category: category)
    }
    
    func saveNote(title: String, category: Category?, note: String){
        CoreDataManager.shared.createNote(title: title, category: category, note: note)
    }
    
    func updateNote(noteID: NSManagedObjectID, newTitle: String?, newContent: String?, newCategory: Category){
        CoreDataManager.shared.updateNote(noteID: noteID,newTitle: newTitle,newContent: newContent, newCategory: newCategory)
    }
    
    func getNote(noteID: NSManagedObjectID){
        if let note = CoreDataManager.shared.getNote(noteID: noteID){
            delegate?.getNote(note: note)
        }
    }
}
