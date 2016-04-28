//
//  PersonalUserViewController.swift
//  BookLet
//
//  Created by Gina Stalica on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class PersonalUserViewController: UITableViewController {
    
    let model: [[UIColor]] = [[UIColor.blueColor()]] //generateRandomData()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Personal User Table View Cell", forIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PersonalUserTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func generateRandomData() -> [[UIColor]] {
        let numRows = 20
        let numItemsPerRow = 15
        
        return (0..<numRows).map { _ in
            return (0..<numItemsPerRow).map { _ in UIColor.randomColor() }
        }
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
    /*
    func generateRandomData() -> [[UIColor]] {
        let numRows = 20
        let numItemsPerRow = 15
        
        return (0..<numRows).map { _ in
            return (0..<numItemsPerRow).map { _ in UIColor.randomColor() }
        }
    }
    */

}
/*
private extension PersonalUserViewController {
    func generateRandomData() -> [[UIColor]] {
        let numRows = 20
        let numItemsPerRow = 15
        
        return (0..<numRows).map { _ in
            return (0..<numItemsPerRow).map { _ in UIColor.randomColor() }
        }
    }
}*/

private extension UIColor {
    class func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}