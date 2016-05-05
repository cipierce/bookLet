//
//  Book.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/3/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class Book: NSObject {
    let bookTitle: String
    let bookOwner: User
    let bookImage: String
    let bookOwned: Bool
    let bookFree: Bool
    let bookBorrower: User?
    init(title: String, owner: User, imagefname: String, bookOwned: Bool, bookFree: Bool){
        self.bookTitle = title
        self.bookOwner = owner
        self.bookImage = imagefname
        self.bookOwned = bookOwned
        self.bookFree = bookFree
        self.bookBorrower = nil
    }
}
