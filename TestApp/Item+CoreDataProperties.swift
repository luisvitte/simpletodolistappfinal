//
//  Item+CoreDataProperties.swift
//  TestApp
//
//  Created by Luis Alessandro Vitte Soto on 20/02/2021.
//
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date
    @NSManaged public var comment: String?

    public var wrappedName: String {
        name ?? "N/A"
    }
    
    public var wrappedComment: String {
        comment ?? "N/A"
    }
    
}

extension Item : Identifiable {

}
