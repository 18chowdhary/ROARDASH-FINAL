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

class GameViewController: UIViewController, CLLocationManagerDelegate {
    
    var goalPace = String()
    var goalPaceFloat: Float!
    var lastPace: String!
    var lastPaceFloat: Float!
    var scene: GameScene!

    
    //Creating the pace label,  timer label & distance label
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var goalPaceLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    // zeroTime is a time interval that will be set to the time at which start is pressed. The timer is declared here
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
        
        
        goalPaceLabel.hidden = true
//        goalPaceLabel.text! = goalPace
        print("The goal pace in GameViewController is \(goalPace)")
        goalPaceFloat = Float(goalPace)
        print(goalPaceFloat+2)

        
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
        // Pop-up request for user to allow locatin services
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            // If user allows location services, call the locationManager to deliver location
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            // An error message
            print("Need to Enable Location")
        }
        
       
        
    }
    
    // Get rid of unnecessary stuff
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // When start button is tapped do these actions
    @IBAction func startTimer(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        zeroTime = NSDate.timeIntervalSinceReferenceDate()
        
        // Set the initial values again so that distance doesn't jump up to wrong number
        distanceTraveled = 0.0
        startLocation = nil
        lastLocation = nil
        timerStartDate = NSDate()
        
        locationManager.startUpdatingLocation()
    }
    
    // Stop updating when stop button is pressed
    @IBAction func stopTimer(sender: AnyObject) {
        timer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    // The process of updating the timer
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var timePassed: NSTimeInterval = currentTime - zeroTime
        
        // Divide time passed by 60 (conversion factor from seconds to minutes) and subtract that value so as not to double-count this time
        let minutes = UInt8(timePassed / 60.0)
        timePassed -= (NSTimeInterval(minutes) * 60)
        // Do the same conversion for seconds
        let seconds = UInt8(timePassed)
        timePassed -= NSTimeInterval(seconds)
        // Convert remaining increase in time to milliseconds
        let millisecsX10 = UInt8(timePassed * 100)
        
        // Format the values of each time component
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMSX10 = String(format: "%02d", millisecsX10)
        
        // Display the components (min, sec, millisec) as a stopwatch
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strMSX10)"
        
        
        // Kill the timer if it runs over the maximum value
        if timerLabel.text == "60:00:00" {
            timer.invalidate()
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations: \(locations)")
        let currentLocation = locations.last!
        
        //var currentPace = currentLocation - locations[currentLocation-1]/1
        //print(currentPace)
        
        
        
        if currentLocation.timestamp.compare(timerStartDate) == NSComparisonResult.OrderedAscending  {
            print("location was recorded before we started the timer, ignoring...")
            return
        }
        
        
        if startLocation == nil {
            // If the startLocation box is empty when locationManager function is called, fill it with the current location
            startLocation = currentLocation
        } else {
            // If the function has already been called, calculate distance travelled
            let lastDistance = lastLocation.distanceFromLocation(currentLocation)
            distanceTraveled += lastDistance * 0.000621371
            
            let trimmedDistance = String(format: "%.2f", distanceTraveled)
            
            // Display the distance travelled
            milesLabel.text = "\(trimmedDistance) Miles"
            lastPace = String(format: "%.2f", 1/(lastDistance*0.0372823))
            
            print(lastPace)
            paceLabel.text = "\(lastPace) Min per Mile"
            lastPaceFloat = Float(lastPace)
            
            showLion(lastPaceFloat, goalPaceFloat: goalPaceFloat)

            
        }
        
        // Update the lastLocation value for next time loop runs
        lastLocation = currentLocation
        
            }
    
    func showLion(lastPaceFloat: Float, goalPaceFloat: Float)
    {
        let actualDuration = CGFloat(1.0)
        let deltaYMid = CGFloat(0.0)
        let deltaYTop = CGFloat(50.0)
        let deltaYBottom = CGFloat(-50.0)
        let minPaceScalar = Float(0.9)
        let maxPaceScalar = Float(1.1)
        
        if scene.lion.position != CGPoint(x: scene.size.width*0.5, y: scene.size.height) && scene.lion.position != CGPoint(x: scene.size.width*0.5, y: 0.0)
        {
            if lastPaceFloat > goalPaceFloat * minPaceScalar && lastPaceFloat < goalPaceFloat * maxPaceScalar {
            
                scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYMid, duration: NSTimeInterval(actualDuration)))
                print("Current pace is in acceptable range")
            
            } else if lastPaceFloat > goalPaceFloat * maxPaceScalar {
            
                scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYTop, duration: NSTimeInterval(actualDuration)))
                print("Current pace is too slow")
            
            } else if lastPaceFloat < goalPaceFloat * minPaceScalar {
            
                scene.lion.runAction(SKAction.moveByX(CGFloat(0.0), y: deltaYBottom, duration: NSTimeInterval(actualDuration)))
                print("Current pace is faster")
            }
        }
        
    }
}