//
//  GameScene.swift
//  Running screen
/*
 * Shreya made a mistake!
 * I accidentally deleted the project I was working in where I'd added a second view to the animation, and in the previous Master Project, I messed up some stuff by deleting the initial GameView Controller, which then made it impossible to get our lion and user to show up. Long story short: this is our new masterproject. 
 
 About this file: 
 - This is the master project, which will hold the final product. 
 - Because this file was originally part of our old roardash repository, I've had to make certain changes. I deleted everything to do with the timer code inside this project because we're going to use the timer code from the OneHourWalker. I deleted the CountdownLabel.swift & CountdownLabel.h files that were in this project, which initally corresponded to the timer that I deleted.
 - I removed the red-black-gradient png too because it's not important right now. 
 - I've also added a start screen with a start button. 
 - Then, I edited the current Game View Controller and made it not the storyboard entry point. I added another View Controller, and connected it to the Game View Controller via Button. This button functions as the start button, and it's currently working (YAY).
 - In the Game View Controller, I added a second view inside a view, and made it transparent. Now we're trying to test if we can add code to this second view by putting a button inside that, if clicked, will cause the animation to start. Not working at the moment... 
 
 */
//  Created by Girls Who Code on 8/2/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
    // Creating lion & user
    let lion = SKSpriteNode(imageNamed: "lion_icon")
    let user = SKSpriteNode(imageNamed: "user_icon")
    
    // Random positions & arcs (Kept if we need it in the future)
//    func random() -> CGFloat {
//        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
//    }
    
//    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
//        return random() * (max - min) + min
//    }
    
    // Main animation displays automatically when app runs
    override func didMoveToView(view: SKView) {
        
        // Making lion appear on screen
        // Setting initial position of lion
        lion.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        // Making lion appear
        addChild(lion)
        
        // Making user appear on screen
        // Set position
        user.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        // Making user appear
        addChild(user)
        
        // Animating lion
        // Setting constant x
        let constantX = size.width * 0.5
        //Setting boundaries for Y position
        let minY = CGFloat(0.0)
        let maxY = size.height * 0.5
        
        // Position the lion at the bottom of the screen
        lion.position = CGPoint(x: constantX, y: minY)
        // Determine speed of the lion
        let actualDuration = CGFloat(3.0)
        // Move the lion
        let actionMove = SKAction.moveTo(CGPoint(x: constantX, y: maxY), duration: NSTimeInterval(actualDuration))
        //let actionMoveDone = SKAction.unhide()
        lion.runAction(SKAction.sequence([actionMove]))
    }
}