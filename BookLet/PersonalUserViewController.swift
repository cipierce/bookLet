//
//  PersonalUserViewController.swift
//  BookLet
//
//  Created by Gina Stalica on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class PersonalUserViewController: UITableViewController {
    
    let model = generateData()
    var storedOffsets = [Int: CGFloat]()
    var categoriesForPersonalUserPage = ["My Favorite Books", "Books I've lent", "Books I've borrowed", "My posted Books"]
    var categoriesForGenericUserPage = ["Favorite Books", "Posted Books"]
    
    var generic = false
    
    @IBOutlet weak var userLabel: UILabel!
    
    var userForPage: User?
    
    func setView() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if userForPage == nil {
            userForPage = delegate.currentUser
        }
//        if let user = userForPage {
            if let userLabel = userLabel {
                userLabel.text = userForPage!.username
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                generic = (userForPage!.username != delegate.currentUser?.username)
            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Personal User Table View Cell", forIndexPath: indexPath)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return generic ? categoriesForGenericUserPage.count : categoriesForPersonalUserPage.count
//        return categories.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PersonalUserTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PersonalUserTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var categories = generic ? categoriesForGenericUserPage : categoriesForPersonalUserPage
        return categories[section]
    }
    
}

extension PersonalUserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Personal User Collection View Cell", forIndexPath: indexPath)
        cell.backgroundColor = model[collectionView.tag][indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }


}