//
//  GameViewController.swift
//  Running screen
//
//  Created by Girls Who Code on 8/2/16.
//  Copyright (c) 2016 Girls Who Code. All rights reserved.
//

import UIKit
import SpriteKit
import CoreLocation
import AVFoundation

class GameViewController: UIViewController, CLLocationManagerDelegate {
    
    var goalPace = String()
    var goalPaceFloat: Float!
    var lastPace: String!
    var lastPaceFloat: Float!
    var scene: GameScene!
    var lastDistance: CLLocationDistance = 0.0

    
    //Creating the pace label, timer label & distance label
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    //@IBOutlet weak var goalPaceLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    var myAudioPlayer = AVAudioPlayer()
    
    @IBAction func callRoar(sender: AnyObject) {
        myAudioPlayer.play()
    }
    //zeroTime is a time interval that will be set to the time at which start is pressed. The timer is declared here
    var zeroTime = NSTimeInterval()
    var timer : NSTimer = NSTimer()

    
    //Setting up location manager & distance stuff
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var distanceTraveled = 0.0
    var timerStartDate: NSDate!
    
    //the view - irrelevant
    @IBOutlet weak var timerView: UIView!
    
    override func viewDidLoad() {
        
        //Pretty sure the next two lines are a relic
//        goalPaceLabel.hidden = true
//        goalPaceLabel.text! = goalPace
        print("The goal pace in GameViewController is \(goalPace)")
        goalPaceFloat = Float(goalPace)
        
        super.viewDidLoad()
        //Automatic view set-up (Apple's code)
        scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
        //Pop-up request for user to allow locatin services
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            //If user allows location services, call the locationManager to deliver location
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            //An error message
            print("Need to Enable Location")
        }
        
        //Directs the audio player to the correct mp3 file
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
    
    //Get rid of unnecessary stuff
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //When start button is tapped
    @IBAction func startTimer(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        zeroTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Set the initial values again so that distance doesn't jump up to wrong number
        distanceTraveled = 0.0
        startLocation = nil
        lastLocation = nil
        timerStartDate = NSDate()
        
        locationManager.startUpdatingLocation()
    }
    
    //Stop updating when stop button is pressed
    @IBAction func stopTimer(sender: AnyObject) {
        timer.invalidate()
        locationManager.stopUpdatingLocation()
        myAudioPlayer.volume = 0
    }
    
    //The process of updating the timer
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var timePassed: NSTimeInterval = currentTime - zeroTime
        
        //Divide time passed by 60 (conversion factor from seconds to minutes) and subtract that value so as not to double-count this time
        let minutes = UInt8(timePassed / 60.0)
        timePassed -= (NSTimeInterval(minutes) * 60)
        //Do the same conversion for seconds
        let seconds = UInt8(timePassed)
        timePassed -= NSTimeInterval(seconds)
        
        //Format the values of each time component
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //Display the components (min, sec, millisec) as a stopwatch
        timerLabel.text = "\(strMinutes):\(strSeconds) min"
        
        
        //Kill the timer if it runs over the maximum value
//        if timerLabel.text == "60:00" {
//            timer.invalidate()
//            locationManager.stopUpdatingLocation()
//        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations: \(locations)")
        let currentLocation = locations.last!
        
        if currentLocation.timestamp.compare(timerStartDate) == NSComparisonResult.OrderedAscending  {
            print("location was recorded before we started the timer, ignoring...")
            return
        }
        
        
        if startLocation == nil {
            //If the startLocation box is empty when locationManager function is called, fill it with the current location
            startLocation = currentLocation
        } else {
            //If the function has already been called, calculate distance travelled
            lastDistance = lastLocation.distanceFromLocation(currentLocation)
            distanceTraveled += lastDistance * 0.000621371
            
            let trimmedDistance = String(format: "%.2f", distanceTraveled)
            
            //Display the distance travelled
            milesLabel.text = "\(trimmedDistance) mi"
            lastPace = String(format: "%.2f", 1/(lastDistance*0.0372823))
            
            print(lastPace)
            paceLabel.text = "\(lastPace) min per mi"
            lastPaceFloat = Float(lastPace)
            
            showLion(lastPaceFloat, goalPaceFloat: goalPaceFloat)

            
        }
        
        //Update the lastLocation value for next time loop runs
        lastLocation = currentLocation
        
            }
    
    func showLion(lastPaceFloat: Float, goalPaceFloat: Float)
    {
        let actualDuration = CGFloat(1.0)
        let deltaYMid = CGFloat(0.0)
        let deltaYTop = CGFloat(5.0)
        let deltaYBottom = CGFloat(-5.0)
        let minPaceScalar = Float(0.2)
        let maxPaceScalar = Float(0.2)
        
        if lastDistance != 0
        {
        if lastPaceFloat > goalPaceFloat + minPaceScalar && lastPaceFloat < goalPaceFloat + maxPaceScalar  {
            print("Current pace is in acceptable range")
            scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYMid, duration: NSTimeInterval(actualDuration)))
            
        } else if lastPaceFloat > goalPaceFloat + maxPaceScalar {
            //Roars and move lion closer to user if it is within bounds of screen
            print("Current pace is too slow")
            
            //Allows user to keep playing their background music
            let sess = AVAudioSession.sharedInstance()
            if sess.otherAudioPlaying {
                _ = try? sess.setCategory(AVAudioSessionCategoryAmbient, withOptions: .DuckOthers)
                _ = try? sess.setActive(true, withOptions: [])
            }
            
            myAudioPlayer.play()
            if scene.lion.position.y <= scene.user.position.y - CGFloat(scene.user.centerRect.height) {
                scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYTop, duration: NSTimeInterval(actualDuration)))
            }
            
            
        } else if lastPaceFloat < goalPaceFloat + minPaceScalar {
            //Moves lion farther from user if it is within bounds of screen
            print("Current pace is faster")
            if scene.lion.position.y >= scene.lion.centerRect.height + CGFloat(20) {
                scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYBottom, duration: NSTimeInterval(actualDuration)))
            }
        }
        }
        else
        {
            paceLabel.text = "No Pace"
        }
        
    }
}