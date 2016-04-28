//
//  Data.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class Data {
    class Book {
        let bookTitle: String
        let bookOwner: String
        let bookImage: String
        let bookOwned: Bool
        let bookFree: Bool
        init(title: String, owner: String, imagefname: String){
            self.bookTitle = title
            self.bookOwner = owner
            self.bookImage = imagefname
            self.bookOwned = false
            self.bookFree = true
        }
    }
    
    let testBooks = [
        Book(title: "Alice in Wonderland", owner: "Gina", imagefname: "aliceInWonderland"),
        Book(title: "Green Eggs and Ham", owner: "Caroline", imagefname: "greenEggsAndHam")
    ]
}
