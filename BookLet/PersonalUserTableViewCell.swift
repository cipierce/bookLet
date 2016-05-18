//
//  PersonalUserTableViewCell.swift
//  BookLet
//
//  Created by Gina Stalica on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class PersonalUserTableViewCell: UITableViewCell {
    /*used this tutorial for the framework of this page:
    ** https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/ */
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension PersonalUserTableViewCell {
    
    func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forSection section: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
}
