//
//  NewBookViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 5/8/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

/*This class controlls the page where the user can upload a new book.*/
class NewBookViewController: UIViewController{

    let data = Data()
    
    var currentUser: User?
    
    var newBook: Book?
    
    struct StringConstants {
        static let newBookSegueIdentifier = "ShowNewBook"
        static let reloadDataIdentifier = "reloadData"
        static let emptyImageFilenameError = "Please enter an image filename"
        static let emptyTitleError = "Please enter a book title"
        static let empty = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOptions()
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            currentUser = delegate.currentUser
        }
    }
    
    /*Manage UI elements*/
    func setupOptions() {
        bookTitle.autocapitalizationType = .Words
        bookImage.autocapitalizationType = .None
        bookImage.autocorrectionType = .No
        bookFree.on = false
        bookFavorite.on = false
    }
    
    @IBOutlet weak var bookTitle: UITextField!
    
    @IBOutlet weak var bookImage: UITextField!
    
    @IBOutlet weak var bookFree: UISwitch!
    
    @IBOutlet weak var bookFavorite: UISwitch!
    
    /*Save a new book.  Check if the user has entered a title and image pathname.*/
    func saveBook() {
        var alertText = StringConstants.empty
        if let title = bookTitle.text {
            if title != StringConstants.empty {
                if let imagefname = bookImage.text {
                    if imagefname != StringConstants.empty {
                        if let error = data.addBook(title: title, owner: currentUser!.username!, imagefname: imagefname, borrowed: false, free: bookFree.on, favorite: bookFavorite.on) {
                                alertText = error
                        } else {
                            newBook = data.fetchBookWithTitleByUser(title, user: currentUser)
                            NSNotificationCenter.defaultCenter().postNotificationName(StringConstants.reloadDataIdentifier, object: nil)
                            bookTitle.text = StringConstants.empty
                            bookImage.text = StringConstants.empty
                            return
                        }
                    } else {
                        alertText = StringConstants.emptyImageFilenameError
                    }
                }
            } else {
                alertText = StringConstants.emptyTitleError
            }
        }
        let alert = UIAlertController(title: "Oops!", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    /*Before segue to adding new book, try to save the book.  If the save is successful, will
    ** segue to book page with information of new book. */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.newBookSegueIdentifier {
            if let destination = segue.destinationViewController as? BookViewController {
                saveBook()
                destination.currentBook = newBook
            }
        }
    }
}
