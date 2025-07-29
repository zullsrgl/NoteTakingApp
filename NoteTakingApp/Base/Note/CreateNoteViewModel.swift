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
}
