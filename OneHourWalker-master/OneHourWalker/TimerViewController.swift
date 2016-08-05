//
//  TimerViewController.swift
//  OneHourWalker
//
//  Created by Matthew Maher on 2/18/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//
// This file has time, distance, and pace capabilities. When run on the computer, it simulates a person walking at an almost constant pace. Pressing go after stop has been used clears the timer (no pause).

import UIKit
import CoreLocation

class TimerViewController: UIViewController, CLLocationManagerDelegate {
    // References that can be reset, or mutable variables (I know I'm getting the terminology wrong)
    // Sets up the text to display for time and distance
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    // zeroTime is a time interval that will be set to the time at which start is pressed. The timer is declared here
    var zeroTime = NSTimeInterval()
    var timer : NSTimer = NSTimer()
    
    // This project uses locationManager to track GPS location and distance
    let locationManager = CLLocationManager()
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    // Give variables starting values when start is called
    var distanceTraveled = 0.0
    var timerStartDate: NSDate!
    // Declare master pace variable
    // When we include this part then Build Fails
    //var pacePerMile: CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
           let lastPace = 1/(lastDistance*0.0372823)
            print(lastPace)
        }
        
        // Update the lastLocation value for next time loop runs
        lastLocation = currentLocation
    }

}
