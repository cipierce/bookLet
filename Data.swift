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
    
    let managedObjectContext = DataController().managedObjectContext
    
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
    
    func addUser(username username: String, emailAddress: String) -> String? {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        entity.setValue(username, forKey: "username")
        entity.setValue(emailAddress, forKey: "emailAddress")
        do {
            try managedObjectContext.save()
        } catch {
            return "Username already in use.  Please try a different username."
        }
        return nil
    }

    func addBook(title title: String, owner: String, imagefname: String, borrowed: Bool, free: Bool) -> String? {
        print("add book with title: \(title)")
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        entity.setValue(title, forKey: "title")
        entity.setValue(imagefname, forKey: "image")
        entity.setValue(borrowed, forKey: "borrowed")
        entity.setValue(free, forKey: "free")
        entity.setValue(fetchUserWithUsername(owner), forKey: "owner")
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
            return "Error saving book"
        }
        return nil
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
    
    func fetchUserWithUsername(username: String) -> User? {
        return findUserInArrayWithUsername(username, users: fetchAllUsers())
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
    
    func fetchPostedBooksForUser(username: String) -> [Book]{
        if let user = fetchUserWithUsername(username) {
            return user.postedBooks?.allObjects as! [Book]
        }
        return []
    }
    
    func fetchFavoriteBooksForUser(username: String) -> [Book]{
        if let user = fetchUserWithUsername(username) {
            return user.favoriteBooks?.allObjects as! [Book]
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