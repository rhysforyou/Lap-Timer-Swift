//
//  Challenge.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class Challenge {
	var name = ""
	var times: [Time] = []

	init(name: String) {
		self.name = name
	}
    
    func addTime(time: Time) {
        times.append(time)
    }
    
    func bestTime() -> Time? {
        return times.sorted { (a: Time, b: Time) -> Bool in
            a.time < b.time
        }.first
    }
    
    func worstTime() -> Time? {
        return times.sorted { (a: Time, b: Time) -> Bool in
            a.time > b.time
        }.first
    }
    
    func averageTime() -> NSTimeInterval {
        // Short circuit if we haven't recorded times
        if times.count == 0 { return 0.0 }
        
        let rawTimes = times.map{ (time: Time) -> NSTimeInterval in
            return time.time
        }
        
        return Double(rawTimes.reduce(0,+)) / Double(rawTimes.count)
    }
}
