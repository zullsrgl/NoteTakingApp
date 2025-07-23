//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Zülal Sarıoğlu on 21.07.2025.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var categoryColor: Data?

}
