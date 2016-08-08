//
//  HomeScreenViewController.swift
//  Welcome Screen with messages
//
//  Created by Girls Who Code on 8/6/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class HomeScreenViewController : UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    let array = ["Strong looks good on you", "You're going to kick asphalt today", "Don't be afraid to fail, be afraid not to try", "You got this", "Be the little engine that did", "The world needs more humans like you", "It always seems impossible until it's done", "It does not matter how slowly you go as long you do not stop", "Accept the challenges so that you can feel the exhilaration of victory", "It's not whether you get knocked down, it's whether you get back", "You can't cross the sea just by staring at the water", "The secret of getting ahead is getting started", "If you can dream it, you can do it", "Smile :D", "Don't watch the clock; do what it does. Keep going", "What doesn't kill you makes you stronger"]
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.orangeColor()
        
        func random() -> Int {
            return Int(Float(arc4random_uniform(15)))
        }
        
        func displayMessage() {
            messageLabel.text = array[random()]
        }
        displayMessage()
        
    }
    
}
