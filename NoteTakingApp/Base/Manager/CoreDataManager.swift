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
                fatalError("Core data loading is fail \(error)")
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
                NotificationCenter.default.post(name: .contextSavedSuccessfully, object: nil)
            } catch {
                print("contex kaydedilemedi")
            }
        }
    }
    
    //MARK: create
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
    
    //MARK: filtering process
    func categoryExists(categoryName: String) -> Bool {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "categoryName ==[c] %@", categoryName)
        
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            print("categori not found \(error.localizedDescription)")
            return false
        }
    }
    
    //MARK: Create Defaults category
    
    func createDefaultCategory(){
        let defaultCategory = Category(context: context)
        defaultCategory.categoryName = "Genaral"
        defaultCategory.categoryColor = Color.secondary.encode()
        
        do {
            try context.save()
            print("defaults category created")
        }catch{
            print("default category not created")
        }
    }
    
    //MARK: Create Note
    func createNote(title: String, category: Category?, note: String) {
        let newNote = Note(context: context)
        
        newNote.noteTitle = title
        newNote.note = note
        newNote.category = category
        saveContext()
    }
    
    //MARK: Fetch all note
    func fetchAllNotes() -> [Note]{
        let request: NSFetchRequest = Note.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    //MARK: delete note
    func deleteNote(noteID: NSManagedObjectID){
        do{
            let noteID = try context.existingObject(with: noteID)
            context.delete(noteID)
            saveContext()
        }catch {
            print("Note can not deleted")
        }
        
    }
    
    //MARK: update note
    func updateNote(noteID: NSManagedObjectID, newTitle: String?, newContent: String?, newCategory: Category?) {
        guard let note = getNote(noteID: noteID) else { return }
        note.noteTitle = newTitle
        note.note = newContent
        note.category = newCategory
        saveContext()
    }
    
    //MARK: Get Note
    func getNote(noteID: NSManagedObjectID) -> Note?{
        do {
            if let object = try context.existingObject(with: noteID) as? Note {
                return object
            }
            
        } catch{
            print("Note not fund")
        }
        return nil
    }
}
