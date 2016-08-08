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
 - In the Game View Controller, I added a second view inside a view, and made it transparent. I added a button to the second view that causes the background color to change (just so I could test if the button was working) and causes the timer to start. I'm sure we can also hook that button up to the distance; I'm just not sure how we could have the button start the animation too... but it's progress!
 
 - UPDATE: from on the train, 08/05 -
 I did some stuff and things are working! I was thinking: we've been going about this the wrong way. What we want is for the animation to start when the timer does. What if we thought of it in a more backwards way? What if the timer started when the animation did? Turns out, this is WAY easier to implement; I added the timer code to the viewDidLoad code inside the GameViewController.swift file because the animation starts when the view loads, so we want the timer to start when the view loads as well. Now, when the user taps "Tap to start ROARDASH", the timer starts as well as the animation. BUT, a second issue arose: we want to user to be able to contro when the timer starts. We don't want the animation to start when they're still getting water, etc. but they want to open the app too. So, I added a second screen to the storyboard before the Running Screen but after the Start Screen. This screen asks the user if they're ready to start running; if they tap yes, they're brought to the Running Screen. If they tap no, then they're brought back to the Start Screen. We've effectively moved the button we wanted on the running screen to a separate screen. Much better! 
 
 - I started experimenting with pace a little too. Pace, or speed, is distance/time. The distance of our animation is the delta_y; that's how far it travels. The time is the duration, or how long it takes for the lion to travel that delta_y. I figured, we could keep the delta_y the same, but change the duration, and effectively make the lion go slower. I can demonstrate this to you later if you would like. It occurred to me though that we'll want the pace of the lion changing continuously, which I have ideas on how to approach, but am still trying to figure out. But, a lot has been accomplished and we should be proud of ourselves for getting this much done at least :) YAY US :D
 
 - I was experimenting again (to no one's surprise) and I tried something sort of cool. Right now, we've set our delta_y, or the distance that the lion travels to 500, which is about right; but if we want the lion to change its speed halfway through, then we need to cut that distance into two halves, or two legs. In the first leg, the lion could be travelling slow, but in the second leg, the lion could be travelling fast. We know that each leg should thus be 250 units in distance, because the two legs added together would be 500, or the distance that we want the lion to travel. So we've got the distance; now to calculate the pace of each leg, we need the duration as well. A larger duration would mean a slower space. A smaller duration would mean a faster pace. Thus, the duration for the first leg could be, for example, 250.0 seconds, which means it would take the lion around 4 minutes to complete the first leg. The second leg could be 50 seconds, which means it would take less than a minute to complete the second leg, and would be much faster. Let's recap - we have all the information we need for each leg. We have a distance and a duration, which combined gives us the pace. But how do we create the pace? I created two actionMove statements, and named each something different. Then I put the actionMove statements into our sequence. Now when you run the project, the lion should run slow for about 4 minutes, and then much faster for the last minute until it reaches the end. This experiment tells me that it's possible to change the pace of the lion... we just need to figure out how to get constant updates.
 
 - UPDATE #2: still on the train... :) 
 I was feeling kind of experimentative so I decided to play around with making an image a button. It's actually really easy; in the Storyboard, I clicked on the button "Tap to start Roardash" and opened up the side panel. There was a dropdown option labeled Image, and when I clicked on that, I could choose a picture to be the button. I chose my baby-bunny.jpg, which I dragged into this project. When I ran the project, "Tap to start ROARDASH" was replaced with my baby-bunny.jpg. :D I'm thinking we can replace baby-bunny.jpg with our logo and have the user click the logo to start :)
 
 - UPDATE #3: at GWC
 I added a background-gradient. In order to do so, I first dragged in the red-black-gradient.png and created a Sprite Node that fills up the screen with this image. I then changed its zPosition and the lion and user's zPositions so they're above this sprite and the backgroud image will not cover the sprites. 
 
 
 */
//  Created by Girls Who Code on 8/2/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
    // Creating lion & user
    let lion = SKSpriteNode(imageNamed: "lion_icon")
    let user = SKSpriteNode(imageNamed: "user_icon")
    let background = SKSpriteNode(imageNamed: "red-black-gradient.jpg")
    
    // Random positions & arcs (Kept if we need it in the future)
//    func random() -> CGFloat {
//        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
//    }
    
//    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
//        return random() * (max - min) + min
//    }
    
    // Main animation displays automatically when app runs
    override func didMoveToView(view: SKView) {
        background.zPosition = 0
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addChild(background)
        
        // Making lion appear on screen
        // Setting initial position of lion
        
        lion.zPosition = 2
        lion.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        // Making lion appear
        addChild(lion)
        
        // Making user appear on screen
        // Set position
        user.zPosition = 1
        user.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        // Making user appear
        addChild(user)
        
    }
    
   
}