//
//  CoreDataManager.swift
//  SharkFeed
//
//  Created by Raxit Cholera on 2/12/18.
//  Copyright © 2018 Raxit Cholera. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerDelegate: NSObjectProtocol
{
    func refreshView()
}

class CoreDataManager: NSObject, SessionDownloadDelegate {
    
    static let sharedManager = CoreDataManager()
    weak var delegate: CoreDataManagerDelegate?
    var keyword:Keyword!
    
    override private init()
    {
        super.init()
    }
    
    //MARK:- SessionDownloadDelegate Method
    
    func resourceDownloaded(status: URLSessionTask.State, resourceData: Data?, error: Error?)
    {
        guard error == nil else {
            
            print("Error while downloading resource: \(String(describing: error?.localizedDescription))")
            return
        }
        
        if (status == .completed || status == .running)
        {
            if let data = resourceData
            {
//                let image = Image(imageData: NSData(data:data), context: appDelegate.stack.context)
                let image = Image(image_t: NSData(data:data), context: appDelegate.stack.context)
                keyword.addToImages(image)
                dbStack.save()
                
                delegate?.refreshView()
            }
        }
    }
}
