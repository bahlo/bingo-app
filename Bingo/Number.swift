//
//  Number.swift
//  Bingo
//
//  Created by Arne Bahlo on 18/09/15.
//  Copyright © 2015 Arne Bahlo. All rights reserved.
//

import CoreData

class Number: NSManagedObject {
    @NSManaged var value: Int32
    @NSManaged var generatedAt: NSDate
}
