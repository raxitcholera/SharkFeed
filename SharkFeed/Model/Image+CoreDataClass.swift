//
//  Image+CoreDataClass.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/13/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject {
    convenience init(image_t: NSData, context: NSManagedObjectContext)
    {
        if let ent = NSEntityDescription.entity(forEntityName: "Image", in: context)
        {
            self.init(entity: ent, insertInto: context)
            self.image_t = image_t
        }
            
        else
        {
            fatalError("Unable to find Entity name!")
        }
    }
}
