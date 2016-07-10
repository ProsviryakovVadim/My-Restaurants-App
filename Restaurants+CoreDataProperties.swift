//
//  Restaurants+CoreDataProperties.swift
//  MyRestaurants
//
//  Created by Vadim on 07.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurants {

    @NSManaged var isVisited: NSNumber?
    @NSManaged var name: String?
    @NSManaged var type: String?
    @NSManaged var location: String?
    @NSManaged var image: NSData?

}
