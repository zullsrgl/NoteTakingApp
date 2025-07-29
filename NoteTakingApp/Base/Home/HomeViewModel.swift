//
//  HomeViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 24.07.2025.
//

import CoreData

protocol HomeViewModelDelegate: AnyObject {
    func categiresFetched(categories: [Category])
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    func getCategories()  {
       let categories =  CoreDataManager.shared.fetchAllCategories()
        delegate?.categiresFetched(categories: categories)
    }
    
    func deleteCategories(category: Category) {
        CoreDataManager.shared.deleteCategory(category: category)
    }
}
