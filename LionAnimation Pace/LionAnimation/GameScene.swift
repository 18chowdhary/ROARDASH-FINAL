//
//  GameScene.swift
//  LionAnimation
//
/*
 Added a lion to top, middle, and bottom of screen that can be shown individually or all at once (to prove they are there); also coded a function to check if there was a positive or negative change in pace, in minutes, outside of the acceptable margin of error (arbitrarily set at 0.5 min) with placeholder values for pace.
 */
//  Created by Girls Who Code on 8/4/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Creating the lion and user sprites.
    let lionTop = SKSpriteNode(imageNamed: "lion_icon")
    let lionMid = SKSpriteNode(imageNamed: "lion_icon")
    let lionBottom = SKSpriteNode(imageNamed: "lion_icon")
    let user = SKSpriteNode(imageNamed: "user_icon")
    
    override func didMoveToView(view: SKView) {
        
        // Making lion appear on the screen
        // Setting the lion's position
        lionMid.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        // Making only middle lion appear
        addChild(lionMid)
        lionMid.hidden = false
        
        // For other lions
        lionTop.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        addChild(lionTop)
        lionTop.hidden = true //hides the lion the easy way
        lionBottom.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        addChild(lionBottom)
        lionBottom.hidden = true
        
        // Making user appear on screen
        // Set position
        user.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        // Making user appear
        addChild(user)
        
        // Animating lion
        // Shows only lionTop and hides the other two
        func showTop() {
            lionTop.hidden = false
            lionMid.hidden = true
            lionBottom.hidden = true
        }
        
        // Shows only lionMid and hides the other two
        func showMid() {
            lionTop.hidden = true
            lionMid.hidden = false
            lionBottom.hidden = true
        }
        
        // Shows only lionBottom and hides the other two
        func showBottom() {
            lionTop.hidden = true
            lionMid.hidden = true
            lionBottom.hidden = false
//            try myAudioPlayer(co)
        }
        
        // Shows all lions
        func showAll() {
            lionTop.hidden = false
            lionMid.hidden = false
            lionBottom.hidden = false
        }
        
        // Placeholder values for pace in minutes. Should be connected to OneHourWalker.
        let oldPace: CGFloat = 7.5
        let newPace: CGFloat = 8
        
        // Compare old and new pace values and show corresponding lion
        func checkPace() {
            let changeInPace = CGFloat(oldPace - newPace)
            if changeInPace >= 0.5 {
                showBottom()
            } else if changeInPace <= -0.5 {
                //roar
                showTop()
            }
        }
        checkPace()
        showAll()
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
