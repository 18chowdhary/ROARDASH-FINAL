//
//  GameViewController.swift
//  Running screen
//
//  Created by Girls Who Code on 8/2/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //will be the timer label; haven't figured out how to change the label's name...
    @IBOutlet weak var thisLabel: UILabel!
    
    //the view
    @IBOutlet weak var timerView: UIView!
    
    var startTime = NSTimeInterval()
    var totalElapsedTime: NSTimeInterval = 0;
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        thisLabel.hidden = true
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
        //Experimenting with changing the background color
        //timerView.backgroundColor = UIColor.blueColor()
        
        //showing a label once the button is clicked
        thisLabel.hidden = false
        
        //the start of the timer code, from the Simple Start Stop Demo
        if (!timer.valid) {
            let aSelector : Selector = #selector(GameViewController.updateTime)
            // Parameters for timer
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
    }
//    @IBAction func buttonClicked(sender: AnyObject) {
//        //Experimenting with changing the background color
//        timerView.backgroundColor = UIColor.blueColor()
//        
//        //showing a label once the button is clicked
//        thisLabel.hidden = false
//        
//        //the start of the timer code, from the Simple Start Stop Demo
//        if (!timer.valid) {
//            let aSelector : Selector = #selector(GameViewController.updateTime)
//            // Parameters for timer
//            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
//            startTime = NSDate.timeIntervalSinceReferenceDate()
        
    
    }
    
    //updates the time
    func updateTime() {
        //        // Time at which timer updates
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        //
        //  Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        //
        //        totalElapsedTime += elapsedTime
        //
        //        let formatter = NSDateFormatter()
        //        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        //        formatter.dateFormat = "mm:ss"
        //
        //        let date = NSDate(timeIntervalSinceReferenceDate: totalElapsedTime)
        //        displayTimeLabel.text = formatter.stringFromDate(date)
        
        //Calculate; the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        // Calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        // Find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        // Add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        // Concatenate minutes, seconds and milliseconds as assign it to the UILabel
        thisLabel.text = "\(strMinutes):\(strSeconds)"
    }


}