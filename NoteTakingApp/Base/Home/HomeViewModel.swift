//
//  HomeViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 24.07.2025.
//

import CoreData

final class HomeViewModel {
    
    func getCategories() -> [Category] {
        return  CoreDataManager.shared.fetchAllCategories()
    }
    
    func deleteCategories(category: Category) {
        CoreDataManager.shared.deleteCategory(category: category)
    }
}
