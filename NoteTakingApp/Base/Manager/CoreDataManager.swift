//
//  CoreDataManager.swift
//  NoteTakingApp
//
//  Created by Zülal Sarıoğlu on 24.07.2025.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var prsistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteTakingApp")
        container.loadPersistentStores { _ , error in
            if let error = error {
                fatalError("Core data yüklmesi sırasında hata oluştu: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext{
        return prsistentContainer.viewContext
    }
    
    //MARK: save
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("contex kaydedilemedi")
            }
        }
    }
    
    //MARK: crate
    func createCategory(name: String, color: UIColor) {
        let category = Category(context: context)
        category.categoryName = name
        category.categoryColor = color.encode()
        saveContext()
    }
    
    //MARK: read
    func fetchAllCategories() -> [Category] {
        let request: NSFetchRequest  = Category.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("category fetch edilemedi")
            return []
        }
    }
    
    //MARK: delete
    func deleteCategory(category: Category) {
        context.delete(category)
        saveContext()
    }
    
    //MARK: filtreleme
    func categoryExists(categoryName: String) -> Bool {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "categoryName ==[c] %@", categoryName)
        
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            print("Kategori aranırken hata oluştu: \(error.localizedDescription)")
            return false
        }
    }
    
    //MARK: Create Defaults category
    
    func createDefaultCategory(){
        let defaultCategory = Category(context: context)
        defaultCategory.categoryName = "Genarall"
        defaultCategory.categoryColor = UIColor.systemBlue.encode()
        
        do {
            try context.save()
            print("defaults category created")
        }catch{
            print("default category not created")
        }
    }
    
}
