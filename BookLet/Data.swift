//
//  Data.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/26/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class Data {
    
    static let gina = User(username: "Gina", emailAddress: "gstalica@bowdoin.edu")
    static let caroline = User(username: "Caroline", emailAddress: "cpierce@bowdoin.edu")
    
    let testBooks = [
        Book(title: "Alice in Wonderland", owner: gina, imagefname: "aliceInWonderland", bookOwned: true, bookFree: false),
        Book(title: "Green Eggs and Ham", owner: caroline, imagefname: "greenEggsAndHam", bookOwned: false, bookFree: true)
    ]
    
    let currentUser = gina
}
