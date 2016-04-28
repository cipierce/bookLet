//
//  BookViewController.swift
//  BookLet
//
//  Created by Caroline Pierce on 4/27/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
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
    
    var currentBook: Data.Book? {
        didSet {
            setView()
        }
    }
    
    func setView() {
        if let currentBook = currentBook {
            if let bookTitle = bookTitle { //is this line necessary?
                bookTitle.text = currentBook.bookTitle
                bookOwner.text = currentBook.bookOwner
                bookImage.image = UIImage(named: currentBook.bookImage)
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
