//
//  PersonalUserViewController.swift
//  BookLet
//
//  Created by Gina Stalica on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class PersonalUserViewController: UITableViewController {
    /*used this tutorial for the framework of this page:
    ** https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/ */
    
    let data = Data()
    
    //let model = generateData()
    var model = [Int: [Book]]()
    
    var storedOffsets = [Int: CGFloat]()
    var categoriesForPersonalUserPage = ["My Favorite Books", "Books I've Lent", "Books I've Borrowed", "My Posted Books"]
    var categoriesForGenericUserPage = ["Favorite Books", "Posted Books"]
    
    var generic = false
    
    @IBOutlet weak var userLabel: UILabel!
    
    var userForPage: User?
    
    func retrieveBooksForUser() {
        if let userForPage = userForPage {
            if generic {
                model[0] = data.fetchFavoriteBooksForUser(userForPage.username!)
                model[1] = data.fetchPostedBooksForUser(userForPage.username!)
            } else {
                model[0] = data.fetchFavoriteBooksForUser(userForPage.username!)
                model[1] = [Book]() // change this
                model[2] = [Book]() // change this
                model[3] = data.fetchPostedBooksForUser(userForPage.username!)
            }
        }
        
    }
    
    func setView() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if userForPage == nil {
            userForPage = delegate.currentUser
        }
        if let userForPage = userForPage {
            if let userLabel = userLabel {
                userLabel.text = userForPage.username
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                generic = (userForPage.username != delegate.currentUser?.username)
                retrieveBooksForUser()
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    // & changed this -- needed to be rows based on user/not, not sections??
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //return generic ? categoriesForGenericUserPage.count : categoriesForPersonalUserPage.count
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Personal User Table View Cell", forIndexPath: indexPath)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return generic ? categoriesForGenericUserPage.count : categoriesForPersonalUserPage.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PersonalUserTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forSection: indexPath.section)
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
        let categories = generic ? categoriesForGenericUserPage : categoriesForPersonalUserPage
        let category = categories[collectionView.tag]
        print("cat: \(category), collectionViewTag: \(collectionView.tag)")
        print("collectionViewTag: \(collectionView.tag)")
        if let count = model[collectionView.tag]?.count {
            return count
        }
        return 0
        //print("\(model[collectionView.tag]!.count)")
        //return model[collectionView.tag]!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Personal User Collection View Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()  // model[collectionView.tag]![indexPath.section][indexPath.item]
        print("collectionViewTag: \(collectionView.tag), indexPath: \(indexPath), indexPath.item: \(indexPath.item)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }


}