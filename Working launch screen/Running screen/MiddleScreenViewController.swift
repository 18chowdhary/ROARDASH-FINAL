//
//  MiddleScreenViewController.swift
//  Running screen
//
//  Created by Girls Who Code on 8/8/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import Foundation
import UIKit

class MiddleScreenViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var goalPaceTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.titleLabel?.textColor = UIColor.redColor()
     //   nextButton.enabled = false
        goalPaceTextField.keyboardType = .DecimalPad
        goalPaceTextField.delegate = self
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "pattern.png")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestView : GameViewController = segue.destinationViewController as!GameViewController
        DestView.goalPace = goalPaceTextField.text!
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
////        if goalPaceTextField.text!.isEmpty && string.isEmpty{
////        
////            nextButton.enabled = false
////        }
////        else {
////            nextButton.enabled = true
////        }
//        return true
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        if goalPaceTextField.text!.isEmpty {
//            
//            nextButton.enabled = false
//        }
//        else {
//            nextButton.enabled = true
//        }
//    }
}