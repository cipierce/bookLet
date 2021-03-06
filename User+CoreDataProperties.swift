//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var emailAddress: String?
    @NSManaged var username: String?
    @NSManaged var userPassword: String?
    @NSManaged var borrowedBooks: NSSet?
    @NSManaged var postedBooks: NSSet?
    @NSManaged var favoriteBooks: NSSet?
    @NSManaged var followers: NSSet?
    @NSManaged var following: NSSet?

}
