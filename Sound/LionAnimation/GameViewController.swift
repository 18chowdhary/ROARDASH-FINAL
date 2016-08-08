//
//  GameViewController.swift
//  LionAnimation
//
//  Created by Girls Who Code on 8/4/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {

    var myAudioPlayer = AVAudioPlayer()
    
//    @IBAction func callRoar(sender: AnyObject) {
//        myAudioPlayer.play()
//    }
    
    @IBAction func callRoar(sender: AnyObject) {
        myAudioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //I don't know what's going on here, but it gave us a SIGABRT message and crashed when run
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .AspectFill
            
//            skView.presentScene(scene)
        }
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
