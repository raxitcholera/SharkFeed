//
//  Image+CoreDataProperties.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/12/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image_t: NSData?
    @NSManaged public var image_c: NSData?
    @NSManaged public var image_l: NSData?
    @NSManaged public var keyword: Keyword?

}
