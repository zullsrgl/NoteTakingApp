//
//  HomeViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 24.07.2025.
//

import CoreData

protocol HomeViewModelDelegate: AnyObject {
    func categoriesFetched(categories: [Category])
    func notesFetched(notes: [Note])
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    func getCategories()  {
        let categories =  CoreDataManager.shared.fetchAllCategories()
        delegate?.categoriesFetched(categories: categories)
    }
    
    func deleteCategories(category: Category) {
        CoreDataManager.shared.deleteCategory(category: category)
    }
    
    func getAllNotes(){
        let notes = CoreDataManager.shared.fetchAllNotes()
        delegate?.notesFetched(notes: notes)
    }
    
   func getSearchText(keyword: String) -> [Category]{
       CoreDataManager.shared.searchCategories(keyword: keyword)
    }
    
    func getNotes(category: Category) -> [Note]{
       let notes = CoreDataManager.shared.fetchNotes(for: category)
       return notes
    }
}
