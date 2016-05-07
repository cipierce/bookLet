//
//  Data.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import Foundation
import CoreData

/*this class is a hack for fetching and save test data*/
class Data {
    
    var books = [Book]()
    var users = [User]()
    
    let managedObjectContext = DataController().managedObjectContext
    
    init(){
        managedObjectContext.mergePolicy = NSRollbackMergePolicy // change later
        addUser(username: "gina", emailAddress: "gstalica@bowdoin.edu")
        if let user = fetchUser() {
            addBook(title: "Alice in Wonderland", owner: user, imagefname: "aliceInWonderland", borrowed: true, free: false)
            if let book = fetchBook() {
                books.append(book)
            }
        }
    }
    
    func addUser(username username: String, emailAddress: String) {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        entity.setValue(username, forKey: "username")
        entity.setValue(emailAddress, forKey: "emailAddress")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failed to save because: \(error)")
        }
    }

    func addBook(title title: String, owner: User, imagefname: String, borrowed: Bool, free: Bool) {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        entity.setValue(title, forKey: "title")
        entity.setValue(imagefname, forKey: "image")
        entity.setValue(borrowed, forKey: "borrowed")
        entity.setValue(free, forKey: "free")
        entity.setValue(owner, forKey: "owner")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failed to save because: \(error)")
        }
    }
    
    func fetchUser() -> User? {
        let userFetch = NSFetchRequest(entityName: "User")
        do {
            let fetchedUser = try managedObjectContext.executeFetchRequest(userFetch) as! [User]
            print("there are \(fetchedUser.count) users")
            return fetchedUser.first!
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return nil
    }

    func fetchBook() -> Book? {
        let bookFetch = NSFetchRequest(entityName: "Book")
        do {
            let fetchedBook = try managedObjectContext.executeFetchRequest(bookFetch) as! [Book]
            print("there are \(fetchedBook.count) books")
            return fetchedBook.first
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return nil
    }

}