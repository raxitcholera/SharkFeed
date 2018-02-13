//
//  Keyword+CoreDataProperties.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/13/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//
//

import Foundation
import CoreData


extension Keyword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Keyword> {
        return NSFetchRequest<Keyword>(entityName: "Keyword")
    }

    @NSManaged public var text: String?
    @NSManaged public var images: NSSet?

}
extension Keyword {
    
    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)
    
    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)
    
    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)
    
    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)
    
}
