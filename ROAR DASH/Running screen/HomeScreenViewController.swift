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
    
    //All possible Welcome Messages
    let array = ["Strong looks good on you!", "You're going to kick asphalt today!", "Don't be afraid to fail, be afraid not to try.", "Don't forget to be awesome!", "Be the little engine that did!", "The world needs more humans like you!", "It always seems impossible until it's done.", "It does not matter how slowly you go as long you do not stop.", "Accept your challenges so that you can feel the exhilaration of victory.", "It's not whether you get knocked down, it's whether you get back up.", "You can't cross the sea just by staring at the water.", "The secret to getting ahead is getting started.", "If you can dream it, you can do it!", "Smile!", "Don't watch the clock; do what it does. Keep going!", "What doesn't kill you makes you stronger!", "Success occurs when your dreams get bigger than your excuses.", "All things are difficult before they are easy.", "A challenge is a chance to grow.", "You have the heart of a champion!", "Today should always be better than yesterday!", "Success is covered in sweat!", "Be somebody no one thought you could be!", "Stop hating yourself for everything you aren't and start loving yourself for everything you are!", "You can do it!", "It is better to live for one day as a lion than for 1,000 days as a sheep.", "Fall seven times, stand up eight.", "Imagine your life is perfect in every respect: What would it look like?", "Whether you think you can or you can't, you're right.", "Life is either a daring adventure or nothing."]
//    I think this would be a good welcome message to take a screenshot of v
//    let array = ["It is better to live for one day as a lion than for 1,000 days as a sheep"]
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "pattern_5.png")!)
        
        func random() -> Int {
            return Int(Float(arc4random_uniform(29)))
        }
        
        func displayMessage() {
            messageLabel.text = array[random()]
        }
        //Randomly generates a new message every time the view loads
        displayMessage()
        
    }
    
}
