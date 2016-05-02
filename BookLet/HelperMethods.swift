//
//  HelperMethods.swift
//  BookLet
//
//  Created by Gina M. Stalica on 5/2/16.
//  Copyright © 2016 Caroline Pierce and Gina Stalica. All rights reserved.
//

import UIKit

func generateRandomData() -> [[UIColor]] {
    let numRows = 5
    let numItemsPerRow = 20
    
    return (0..<numRows).map { _ in
        return (0..<numItemsPerRow).map { _ in UIColor.randomColor() }
    }
}


extension UIColor {
    class func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}




