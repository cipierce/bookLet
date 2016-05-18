//
//  BookViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/27/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit
import MessageUI

/*Controlls the individual book page.  Allows user to request book from other user via email.*/
class BookViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = UIFont(name: "Avenir", size: 20) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        }
        setView()
    }

    struct StringConstants {
        static let userSegueIdentifier = "ShowUserSegue"
    }
    
    @IBOutlet weak var bookTitle: UILabel!

    @IBOutlet weak var bookOwner: UIButton!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var buyBookButton: UIButton!
    
    @IBAction func buyBook() {
        let mailController = buildMailController(withRecipient: currentBook!.owner!.emailAddress!,
            withSubjectLine: "Request for \(currentBook!.title!)",
            withBodyText: "I'd love to read this book please!")
        sendToMail(mailController)
    }
    
    @IBAction func returnBook() {
        let mailController = buildMailController(withRecipient: currentBook!.owner!.emailAddress!,
            withSubjectLine: "Ready to return \(currentBook!.title)",
            withBodyText: "I'm done with this book and would like to return it! Where should I drop it off?")
        sendToMail(mailController)
    }
    
    @IBOutlet weak var returnBookButton: UIButton!
    
    var currentBook: Book? {
        didSet {
            setView()
        }
    }
    
    //manage UI elements
    func setView() {
        if let currentBook = currentBook {
            if let bookTitle = bookTitle {
                bookTitle.adjustsFontSizeToFitWidth = true
                bookImage.contentMode = .ScaleAspectFit
                bookTitle.text = currentBook.title
                bookOwner.setTitle(currentBook.owner!.username, forState: .Normal)
                bookImage.image = UIImage(named: currentBook.image!)
                returnBookButton.enabled = currentBook.borrowed
                if currentBook.free {
                    buyBookButton.setTitle("Borrow book", forState: .Normal)
                }
            }
        }
    }
    
    // - MARK: email
    
    /*Try to send mail*/
    func sendToMail(mailController: MFMailComposeViewController) {
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Looks like we couldn't access your mailbox", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    /*Set-up mail*/
    func buildMailController(withRecipient recipient: String, withSubjectLine subject: String, withBodyText text: String) -> MFMailComposeViewController {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setToRecipients([recipient])
        mailController.setSubject(subject)
        mailController.setMessageBody(text, isHTML: false)
        return mailController
    }
    
    /*conform to MFMailComposeViewControllerDelegate*/
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StringConstants.userSegueIdentifier {
            if let destination = segue.destinationViewController as? PersonalUserViewController {
                if let currentBook = currentBook {
                    destination.userForPage = currentBook.owner!
                }
            }
        }
    }

}
