//
//  Keyword+CoreDataProperties.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/12/18.
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
