//
//  Book+CoreDataProperties.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String?
    @NSManaged var image: String?
    @NSManaged var borrowed: Bool
    @NSManaged var free: Bool
    @NSManaged var id: String?
    @NSManaged var owner: User?
    @NSManaged var borrower: User?

}
