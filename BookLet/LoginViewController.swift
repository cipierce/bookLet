//
//  LoginViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var dataController = Data()
    
    struct StringConstants {
        static let loginSegueIdentifier = "LoginSegue"
    }

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailAddressField: UITextField!
    
    @IBAction func login(sender: UIButton) {
        var alertText = ""
        if let username = usernameField.text {
            if username != "" {
                if let emailAddress = emailAddressField.text {
                    if emailAddress != "" {
                        if let error = dataController.addUser(username: username, emailAddress: emailAddress) {
                            alertText = error
                        } else {
                            return
                        }
                    } else {
                        alertText = "Please enter an email address"
                    }
                }
            } else {
                alertText = "Please enter a username"
            }
        }
        let alert = UIAlertController(title: "Oops!", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.loginSegueIdentifier {
            if let destination = segue.destinationViewController as? UITabBarController {
                print("good")
            }
        }
    }
    
}
