//
//  User.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/3/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class User: NSObject {
    let username: String
    let emailAddress: String
    
    init(username: String, emailAddress: String){
        self.username = username
        self.emailAddress = emailAddress
    }
}
