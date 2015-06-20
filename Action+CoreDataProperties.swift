//
//  Action+CoreDataProperties.swift
//  ValueFaces
//
//  Created by JIAN WANG on 6/20/15.
//  Copyright © 2015 JWANG. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Action {

    @NSManaged var content: String?
    @NSManaged var date: NSTimeInterval
    @NSManaged var topValue: NSManagedObject?

}
