//
//  Data.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import Foundation
import CoreData

/*This class manages fetching and saving data to CoreData using a single managed object context.  We
** implemented Core Data using the following tutorials:
** http://code.tutsplus.com/series/core-data-from-scratch--cms-653
** http://www.codebeaulieu.com/10/adding-core-data-using-swift-2 */
class Data {
    
    let managedObjectContext = DataController().managedObjectContext
    
    // - MARK: saving data
    
    func addUser(username username: String, emailAddress: String, userPassword: String) -> String? {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        entity.setValue(username, forKey: "username")
        entity.setValue(emailAddress, forKey: "emailAddress")
        entity.setValue(userPassword, forKey: "userPassword")
        do {
            try managedObjectContext.save()
        } catch {
            return "Username already in use.  Please try a different username."
        }
        return nil
    }

    func addBook(title title: String, owner: String, imagefname: String, borrowed: Bool, free: Bool, favorite: Bool) -> String? {
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        entity.setValue(title, forKey: "title")
        entity.setValue(imagefname, forKey: "image")
        entity.setValue(borrowed, forKey: "borrowed")
        entity.setValue(free, forKey: "free")
        let user = fetchUserWithUsername(owner)
        if favorite {
            entity.setValue(user, forKey: "favoritedBy")
        }
        entity.setValue(user, forKey: "owner")
        let idNumber = fetchAllBooks().count + 1 //this only works while don't allow for deleting books
        entity.setValue("\(idNumber)", forKey: "id")
        do {
            try managedObjectContext.save()
        } catch {
            return "Error saving book"
        }
        return nil
    }
    
    // - MARK: fetching data
    
    func fetchAllUsers() -> [User] {
        let userFetch = NSFetchRequest(entityName: "User")
        do {
            let fetchedUsers = try managedObjectContext.executeFetchRequest(userFetch) as! [User]
            return fetchedUsers
        } catch {
            fatalError("failed to fetch users because: \(error)")
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
            fatalError("failed to fetch books because: \(error)")
        }
        return []
    }
    
    func fetchBookWithTitleByUser(title: String, user: User?) -> Book? {
        for book in fetchAllBooks() {
            if (book.title == title) && (book.owner?.username == user?.username) {
                return book
            }
        }
        return nil
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
    
    func fetchBorrowedBooksForUser(username: String) -> [Book]{
        if let user = fetchUserWithUsername(username) {
            return user.borrowedBooks?.allObjects as! [Book]
        }
        return []
    }
    
    // - MARK: helper
    
    func findUserInArrayWithUsername(username: String, users: [User]) -> User? {
        for user in users {
            if user.username == username {
                return user
            }
        }
        return nil
    }

}