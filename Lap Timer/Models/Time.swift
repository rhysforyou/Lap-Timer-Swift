//
//  Time.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class Time {
    var time: NSTimeInterval!
	var dateRecorded: NSDate
	var comment: String?
    
    init() {
        self.dateRecorded = NSDate.date()
    }
    
    convenience init(time: NSTimeInterval, dateRecorded: NSDate) {
        self.init()
        self.time = time
        self.dateRecorded = dateRecorded
    }
}
