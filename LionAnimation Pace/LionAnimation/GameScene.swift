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
    let lion = SKSpriteNode(imageNamed: "lion_icon")
    let user = SKSpriteNode(imageNamed: "user_icon")
    
    
    override func didMoveToView(view: SKView) {
        
        // Making lion appear on the screen
        // Setting the lion's position
        //Positioning of lion
        //Constant x because lion will stay centered on the screen
        let constantX = size.width * 0.5
        //Min Y is the starting Y of the lion
        let minY = CGFloat(0.0)
        //Max Y is the ending Y of the lion
        let maxY = size.height * 0.5
        
        // Position the lion at the bottom of the screen
        lion.position = CGPoint(x: constantX, y: minY)
        var lionY = minY
        // Making lion appear
        addChild(lion)
        
        
        // Making user appear on screen
        // Set position
        user.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        // Making user appear
        addChild(user)
        
        // Animating lion
        // Keeping constant change in x to 0 because we won't be moving the lion horizontally
        let delta_x = 0.0
        // Setting change in y to be var with initial value 500 because we will want this to change based on the user's pace
        var actualDuration = CGFloat(5)
        var delta_y: CGFloat
        var actionMove: SKAction
        for i in 0 ..< 10 {
            
            lionY += 50
            lion.position = CGPoint(x: constantX, y: lionY)
        }

      
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
