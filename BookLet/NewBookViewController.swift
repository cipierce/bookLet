//
//  NewBookViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/8/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class NewBookViewController: UIViewController {

    let data = Data()
    
    var currentUser: User?
    
    struct StringConstants {
        static let newBookSegueIdentifier = "ShowNewBook"
        static let reloadDataIdentifier = "reloadData"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixTextFields()
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        currentUser = delegate.currentUser
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fixTextFields() {
        bookTitle.autocapitalizationType = .Words
        bookImage.autocapitalizationType = .None
        bookImage.autocorrectionType = .No
    }
    
    var newBook: Book?
    
    @IBOutlet weak var bookTitle: UITextField!
    
    @IBOutlet weak var bookImage: UITextField!
    
    @IBOutlet weak var bookFree: UISwitch!
    
    func saveBook() {
        var alertText = ""
        if let title = bookTitle.text {
            if title != "" {
                if let imagefname = bookImage.text {
                    if imagefname != "" {
                        if let error = data.addBook(title: title, owner: currentUser!.username!, imagefname: imagefname, borrowed: false, free: bookFree.on) {
                                alertText = error
                        } else {
                            newBook = data.fetchBookWithTitleByUser(title, user: currentUser)
                            NSNotificationCenter.defaultCenter().postNotificationName(StringConstants.reloadDataIdentifier, object: nil)
                            bookTitle.text = ""
                            bookImage.text = ""
                            return
                        }
                    } else {
                        alertText = "Please enter an image filename"
                    }
                }
            } else {
                alertText = "Please enter a book title"
            }
        }
        let alert = UIAlertController(title: "Oops!", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.newBookSegueIdentifier {
            if let destination = segue.destinationViewController as? BookViewController {
                saveBook()
                destination.currentBook = newBook
            }
        }
    }


}
