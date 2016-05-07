//
//  FeedTableViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/25/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit
import CoreData

class FeedTableViewController: UITableViewController {
    
    struct StringConstants {
        static let bookSegueIdentifier = "ShowBookSegue"
    }

    var books = [Book]()
    
    let managedObjectContext = DataController().managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
        //FIXME: move once we have add user page
        addUser(username: "gina", emailAddress: "gstalica@bowdoin.edu")
        if let user = fetchUser() {
            addBook(title: "Alice in Wonderland", owner: user, imagefname: "aliceInWonderland", borrowed: true, free: false)
            if let book = fetchBook() {
                books.append(book)
            }
        }
        
    }
    //FIXME: move later to central location
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
    //FIXME: move later
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
    
    //FIXME: move later to central location
    func fetchUser() -> User? {
        let userFetch = NSFetchRequest(entityName: "User")
        do {
            let fetchedUser = try managedObjectContext.executeFetchRequest(userFetch) as! [User]
            print(fetchedUser.first!.username!)
            return fetchedUser.first!
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return nil
    }
    //FIXME: move!
    func fetchBook() -> Book? {
        let bookFetch = NSFetchRequest(entityName: "Book")
        do {
            let fetchedBook = try managedObjectContext.executeFetchRequest(bookFetch) as! [Book]
            print(fetchedBook.first!.title!)
            return fetchedBook.first
        } catch {
            fatalError("failed to save because: \(error)")
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as? FeedTableViewCell
        let entry = books[indexPath.row]
        cell!.bookTitle.text = entry.title
        cell!.bookOwnerUsername.text = entry.owner!.username
        cell!.bookIcon.contentMode = .ScaleAspectFit
        cell!.bookIcon.image = UIImage(named: entry.image!)
        return cell!
        //FIXME: needs error handling
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    /*send book information to next book page*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.bookSegueIdentifier {
            if let destination = segue.destinationViewController as? BookViewController {
                if let bookIndex = tableView.indexPathForSelectedRow {
                    destination.currentBook = books[bookIndex.row]
                }
            }
        }
    }


}
