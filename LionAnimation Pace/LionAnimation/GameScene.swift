//
//  GameScene.swift
//  LionAnimation
//
/*
 Check here for all the pre-coding stuff I did to this file! Storyboard, etc.
 - About this project
    This project holds all the code for the lion animation, which will be merged with the start code. It is a game application.
 - Storyboarding 
    There was no storyboarding required for this project.
 - Other prep stuff
    I dragged and dropped the lion_icon and user_icon pngs from the Running screen project.
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
        }
        
        // Shows all lions
        func showAll() {
            lionTop.hidden = false
            lionMid.hidden = false
            lionBottom.hidden = false
        }
        
        let oldPace: CGFloat = 7.5
        let newPace: CGFloat = 8
        func checkPace() {
            let changeInPace = CGFloat(oldPace - newPace)
            if changeInPace >= 0.5 {
                showBottom()
            } else if changeInPace <= -0.5 {
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
