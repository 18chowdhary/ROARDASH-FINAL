//
//  WelcomeViewController.swift
//  Welcome Screen with messages
//
//  Created by Girls Who Code on 8/6/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class WelcomeViewController : UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    let array = ["Strong looks good on you", "You're going to kick asphalt today", "Don't be afraid to fail, be afraid not to try", "You got this", "Be the little engine that did it", ]

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.orangeColor()
        
        func random() -> Int {
            return Int(Float(arc4random_uniform(6)))
        }
        
        func displayMessage() {
            messageLabel.text = array[random()]
        }
        displayMessage()

    }
    
}
