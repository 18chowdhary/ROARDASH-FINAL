//
//  ViewController.swift
//  SplittingViewOfScreen
//
//  Created by Girls Who Code on 8/4/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    let lion = SKSpriteNode(imageNamed: "lion_icon")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBOutlet weak var daddyView: UIView!
    
    @IBAction func buttonClicked(sender: AnyObject) {
        print("Button was clicked")
        daddyView.backgroundColor = UIColor.blueColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

