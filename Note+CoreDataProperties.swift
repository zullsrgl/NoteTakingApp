//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Zülal Sarıoğlu on 7.08.2025.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var noteTitle: String?
    @NSManaged public var note: String?
    @NSManaged public var styledText: NSAttributedString?

}
