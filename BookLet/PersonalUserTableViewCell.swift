//
//  PersonalUserTableViewCell.swift
//  BookLet
//
//  Created by Gina Stalica on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class PersonalUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

}

extension PersonalUserTableViewCell {
    
    func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
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
