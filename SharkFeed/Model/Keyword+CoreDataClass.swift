//
//  Keyword+CoreDataClass.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/13/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Keyword)
public class Keyword: NSManagedObject {
    convenience init(text:String, context: NSManagedObjectContext)
    {
        if let ent = NSEntityDescription.entity(forEntityName: "Keyword", in: context)
        {
            self.init(entity: ent, insertInto: context)
            self.text = text
        }
            
        else
        {
            fatalError("Unable to find Entity name!")
        }
    }
}
