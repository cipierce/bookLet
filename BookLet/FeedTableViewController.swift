//
//  FeedTableViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/25/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit
import CoreData

/*Controller for the activity feed page.  Should show book activity for users
** the current user follows, but following is not yet implemented.*/
class FeedTableViewController: UITableViewController {
    
    struct StringConstants {
        static let bookSegueIdentifier = "ShowBookSegue"
        static let cellIdentifier = "FeedCell"
        static let reloadDataIdentifier = "reloadData"
    }

    var data = Data()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Sets up observer for reloading data when user adds a new book.
        NSNotificationCenter.defaultCenter().addObserverForName(StringConstants.reloadDataIdentifier, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { _ in
                self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.fetchAllBooks().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(StringConstants.cellIdentifier, forIndexPath: indexPath) as? FeedTableViewCell {
            let entry = data.fetchAllBooks()[indexPath.row]
            cell.bookTitle.text = entry.title
            cell.bookOwnerUsername.text = entry.owner!.username
            cell.bookIcon.contentMode = .ScaleAspectFit
            if let image = entry.image {
                cell.bookIcon.image = UIImage(named: image)
            }
            return cell
        }
        return tableView.dequeueReusableCellWithIdentifier(StringConstants.cellIdentifier, forIndexPath: indexPath)
    }

    // MARK: - Navigation

    /*Send book information to next book page*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.bookSegueIdentifier {
            if let destination = segue.destinationViewController as? BookViewController {
                if let bookIndex = tableView.indexPathForSelectedRow {
                    destination.currentBook = data.fetchAllBooks()[bookIndex.row]
                }
            }
        }
    }


}
