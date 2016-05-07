//
//  BookViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/27/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit
import MessageUI

class BookViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let testData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var bookTitle: UILabel!

    @IBOutlet weak var bookOwner: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var buyBookButton: UIButton!
    
    @IBAction func buyBook() {
        let mailController = buildMailController(withRecipient: currentBook!.bookOwner.emailAddress!,
            withSubjectLine: "Request for \(currentBook!.bookTitle)",
            withBodyText: "I'd love to read this book please!")
        sendToMail(mailController)
    }
    
    @IBAction func returnBook() {
        let mailController = buildMailController(withRecipient: currentBook!.bookOwner.emailAddress!,
            withSubjectLine: "Ready to return \(currentBook!.bookTitle)",
            withBodyText: "I'm done with this book and would like to return it! Where should I drop it off?")
        sendToMail(mailController)
    }
    
    func sendToMail(mailController: MFMailComposeViewController) {
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Looks like we couldn't access your mailbox", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
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
    
    @IBOutlet weak var returnBookButton: UIButton!
    
    var currentBook: Book? {
        didSet {
            setView()
        }
    }
    
    func setView() {
        if let currentBook = currentBook {
            if let bookTitle = bookTitle { //FIXME: is this line necessary?
                bookTitle.adjustsFontSizeToFitWidth = true
                bookImage.contentMode = .ScaleAspectFit
                bookTitle.text = currentBook.bookTitle
                bookOwner.text = currentBook.bookOwner.username
                bookImage.image = UIImage(named: currentBook.bookImage)
                returnBookButton.enabled = currentBook.bookOwned
                if currentBook.bookFree {
                    buyBookButton.setTitle("Borrow book", forState: .Normal)
                }
            }
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
