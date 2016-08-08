//
//  MiddleScreenViewController.swift
//  Running screen
//
//  Created by Girls Who Code on 8/8/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import Foundation
import UIKit

class MiddleScreenViewController : UIViewController{
    
    @IBOutlet weak var goalPaceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestView : GameViewController = segue.destinationViewController as!GameViewController
        DestView.goalPace = goalPaceTextField.text!
    }
}