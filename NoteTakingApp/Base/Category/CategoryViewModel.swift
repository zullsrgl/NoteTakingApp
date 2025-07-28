//
//  CategoryViewModel.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 24.07.2025.
//

import UIKit

final class CategoryViewModel {
    
    func createCategory(categoryName: String, categoryColor: UIColor) {
        CoreDataManager.shared.createCategory(name: categoryName, color: categoryColor)
    }
    
    func categoryExists(name: String) -> Bool{
        CoreDataManager.shared.categoryExists(categoryName: name)
    }
}
