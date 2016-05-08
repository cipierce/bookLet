//
//  LoginViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var data = Data()
    
    var loginUser: User?
    
    struct StringConstants {
        static let loginSegueIdentifier = "LoginSegue"
    }

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailAddressField: UITextField!
    
    //FIXME: call this at some point
    func fixTextFields() {
        usernameField.autocapitalizationType = .None
        usernameField.autocorrectionType = .No
        emailAddressField.autocorrectionType = .No
        emailAddressField.autocapitalizationType = .None
    }

    @IBAction func loginAsNew() {
        login(asNewUser: true)
    }
    
    @IBAction func loginAsExisting(sender: UIButton) {
        login(asNewUser: false)
    }
    
    func login(asNewUser asNewUser: Bool) {
        var alertText = ""
        if let username = usernameField.text {
            if username != "" {
                if let emailAddress = emailAddressField.text {
                    if emailAddress != "" {
                        if asNewUser {
                            if let error = data.addUser(username: username, emailAddress: emailAddress) {
                                alertText = error
                            } else {
                                return
                            }
                        } else {
                            if let returningUser = data.fetchUserWithUsername(username) {
                                loginUser = returningUser
                                return
                            } else {
                                alertText = "No user exists with username \(username)"
                            }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        fixTextFields()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.loginSegueIdentifier {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.currentUser = loginUser
        }
    }
    
}
