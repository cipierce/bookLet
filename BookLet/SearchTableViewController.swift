//
//  SearchTableViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/28/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    /*Search implemented by adapting tutorial:
    ** https://www.raywenderlich.com/113772/uisearchcontroller-tutorial */
    
    struct StringConstants {
        static let bookSegueIdentifier = "ShowSearchResult"
        static let reloadDataIdentifier = "reloadData"
    }
    
    let data = Data()
    
    var filteredData: [Book] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredData = data.fetchAllBooks().filter { book in
                return book.title!.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName(StringConstants.reloadDataIdentifier, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { _ in
            self.tableView.reloadData()
        })
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredData.count
        }
        return data.fetchAllBooks().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as? SearchTableViewCell {
            let entry: Book
            if searchController.active && searchController.searchBar.text != "" {
                entry = filteredData[indexPath.row]
            } else {
                entry = data.fetchAllBooks()[indexPath.row]
            }
            cell.bookTitle.text = entry.title
            cell.bookOwner.text = entry.owner!.username
            return cell
        }
        return tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.bookSegueIdentifier {
            if let destination = segue.destinationViewController as? BookViewController {
                if let bookIndex = tableView.indexPathForSelectedRow {
                    if searchController.active && searchController.searchBar.text != "" {
                        destination.currentBook = filteredData[bookIndex.row]
                    } else {
                        destination.currentBook = data.fetchAllBooks()[bookIndex.row]
                    }
                }
            }
        }
    }
    

}
