//
//  LoginViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/7/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

/*This class controls the login page.  The user can login as a new or existing user.*/
class LoginViewController: UIViewController {
    
    var data = Data()
    
    var loginUser: User?
    
    struct StringConstants {
        static let loginSegueIdentifier = "LoginSegue"
        static let empty = ""
        static let incorrectPasswordError = "Incorrect password, please try again"
        static let emptyPasswordError = "Please enter a password"
        static let emptyEmailAddressError = "Please enter an email address"
        static let emptyUsernameError = "Please enter a username"
    }

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailAddressField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    /*Manage UI elements*/
    func fixTextFields() {
        if let usernameField = usernameField {
            usernameField.autocapitalizationType = .None
            usernameField.autocorrectionType = .No
        }
        if let emailAddressField = emailAddressField {
            emailAddressField.autocorrectionType = .No
            emailAddressField.autocapitalizationType = .None
        }
        if let passwordField = passwordField {
            passwordField.autocapitalizationType = .None
            passwordField.autocorrectionType = .No
        }
    }

    @IBOutlet weak var newUserButton: UIButton!
    @IBAction func loginAsNew() { login(asNewUser: true) }
    
    @IBOutlet weak var existingUserButton: UIButton!
    @IBAction func loginAsExisting(sender: UIButton) { login(asNewUser: false) }
    
    /*This handles the login logic.  For new users, they must submit a username that is not already in use.
    ** If successful, they are added to CoreData as a new user.  For existing users, they must use the correct
    ** password. All fields must be populated in either case.*/
    func login(asNewUser asNewUser: Bool) {
        var alertText = StringConstants.empty
        if let username = usernameField.text {
            if username != StringConstants.empty {
                if let emailAddress = emailAddressField.text {
                    if emailAddress != StringConstants.empty {
                        if let userPassword = passwordField.text {
                            if userPassword != StringConstants.empty {
                                if asNewUser {
                                    if let error = data.addUser(username: username, emailAddress: emailAddress, userPassword: userPassword) {
                                        alertText = error
                                    } else {
                                        loginUser = data.fetchUserWithUsername(username)
                                        return
                                    }
                                } else {
                                    if let returningUser = data.fetchUserWithUsername(username) {
                                        if userPassword == returningUser.userPassword {
                                            loginUser = returningUser
                                            return
                                        } else {
                                            alertText = StringConstants.incorrectPasswordError
                                        }
                                        
                                    } else {
                                        alertText = "No user exists with username \(username)"
                                    }
                                }
                            } else {
                                alertText = StringConstants.emptyPasswordError
                            }
                        }
                    } else {
                        alertText = StringConstants.emptyEmailAddressError
                    }
                }
            } else {
                alertText = StringConstants.emptyUsernameError
            }
        }
        let alert = UIAlertController(title: "Oops!", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fixTextFields()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "booksT")!)
        // image: http://66.media.tumblr.com/3f0bc3f7135258853503b0e23c6bb795/tumblr_meqvadCGYZ1qzb5wzo1_1280.jpg
    }
    
    // MARK: - Navigation
    
    /*Set up current user and create custom back button*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.loginSegueIdentifier {
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                appDelegate.currentUser = loginUser
            }
            let backButton = UIBarButtonItem()
            backButton.title = StringConstants.empty
            backButton.setBackButtonBackgroundImage(UIImage(named: "logout"), forState: .Normal, barMetrics: .Default)
            navigationItem.backBarButtonItem = backButton
        }
    }
    
}
