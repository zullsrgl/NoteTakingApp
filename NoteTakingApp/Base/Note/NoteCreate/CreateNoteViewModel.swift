//
//  NoteViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 29.07.2025.
//

import CoreData

protocol NoteViewModelDelegate: AnyObject {
    func fectedAllCategories(categories: [Category])
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
}
