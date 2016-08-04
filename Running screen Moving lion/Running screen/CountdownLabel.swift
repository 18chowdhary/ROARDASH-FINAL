//
//  CountdownLabel.swift
//  Running screen
//
//  Created by Girls Who Code on 8/3/16.
//  Copyright © 2016 Girls Who Code. All rights reserved.
//
// Tutorial from http://tutorials.tinyappco.com/SwiftGames/Timer

import SpriteKit
class CountdownLabel: SKLabelNode {
    //    let duration = 60
    var endTime:NSDate!
    var timeNow = NSDate();
    func update() {
        let timeLeftInteger = Int(timeLeft())
        text = String(timeLeftInteger)
    }
    func startWithDuration(duration: NSTimeInterval) {
        var endTime = timeNow.dateByAddingTimeInterval(duration)
    }
    func hasFinished() -> Bool {
        return timeLeft() == 0;
    }
    private func timeLeft() -> NSTimeInterval {
        let now = NSDate();
        let remainingSeconds = endTime.timeIntervalSinceDate(now)
        return max(remainingSeconds, 0)
    }
}


