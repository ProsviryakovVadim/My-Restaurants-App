//
//  Restaurants.swift
//  MyRestaurants
//
//  Created by Vadim on 07.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import Foundation
import CoreData


class Restaurants: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("Restaurants"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
    }
}
