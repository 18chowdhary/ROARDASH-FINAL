//
//  SoundViewController.swift
//  LionAnimation
//
//  Created by Girls Who Code on 8/5/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//

import UIKit
import AVFoundation
//Pretty sure none of this code does anything

class ViewController : UIViewController {
    // Create audio player
    var myAudioPlayer = AVAudioPlayer()
    
    @IBAction func callRoar(sender: AnyObject) {
        myAudioPlayer.play()
    }
    
    override func viewDidLoad() {
        let lionRoarPathString = NSBundle.mainBundle().pathForResource("lion_roar", ofType: "mp3")
        
        if let lionRoarPathString = lionRoarPathString {
            let soundURL = NSURL(fileURLWithPath: lionRoarPathString)
            do {
                try myAudioPlayer = AVAudioPlayer(contentsOfURL: soundURL)
            } catch {
                print("Error with sound playback")
            }
        }
        
    }
}