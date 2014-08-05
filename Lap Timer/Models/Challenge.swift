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
    
    func addTime(timeInterval: NSTimeInterval) {
        let time = Time(time: timeInterval, dateRecorded: NSDate.date())
        times.append(time)
    }
}
