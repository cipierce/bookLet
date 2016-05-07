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
        addUser(username: "caroline", emailAddress: "cpierce@bowdoin.edu")
        users = fetchAllUsers()
        if let user = findUserInArrayWithUsername("gina", users: users) {
            addBook(title: "Alice in Wonderland", owner: user, imagefname: "aliceInWonderland", borrowed: true, free: false)
        }
        if let user = findUserInArrayWithUsername("caroline", users: users) {
            addBook(title: "Green Eggs And Ham", owner: user, imagefname: "greenEggsAndHam", borrowed: false, free: true)
        }
        books = fetchAllBooks()
        print("\(books.count) books and \(users.count) users")
    }
    
    func fetchPostedBooksForUser(username username: String) -> [Book] {
        var returnBooks = [Book]()
        let userFetch = NSFetchRequest(entityName: "User")
        do {
            let fetchedUsers = try managedObjectContext.executeFetchRequest(userFetch) as! [User]
            if let testUser = findUserInArrayWithUsername(username, users: fetchedUsers) {
                if let books = testUser.postedBooks {
                    for book in books {
                        returnBooks.append(book as! Book)
                    }
                }
            }
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return returnBooks
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
        print("add book with title: \(title)")
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        entity.setValue(title, forKey: "title")
        entity.setValue(imagefname, forKey: "image")
        entity.setValue(borrowed, forKey: "borrowed")
        entity.setValue(free, forKey: "free")
        entity.setValue(owner, forKey: "owner")
        //FIXME: unique id hack
        var idNumber = 0
        if let lastBook = fetchAllBooks().last {
            if let lastBookId = lastBook.id {
                idNumber = Int(lastBookId)! + 1
            }
        }
        entity.setValue("\(idNumber)", forKey: "id")
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("failed to save because: \(error)")
        }
    }
    
    func fetchAllUsers() -> [User] {
        let userFetch = NSFetchRequest(entityName: "User")
        do {
            let fetchedUsers = try managedObjectContext.executeFetchRequest(userFetch) as! [User]
            return fetchedUsers
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return []
    }

    func fetchAllBooks() -> [Book] {
        let bookFetch = NSFetchRequest(entityName: "Book")
        do {
            let fetchedBooks = try managedObjectContext.executeFetchRequest(bookFetch) as! [Book]
            return fetchedBooks
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return []
    }
    
    func findUserInArrayWithUsername(username: String, users: [User]) -> User? {
        for user in users {
            if user.username == username {
                return user
            }
        }
        return nil
    }

}