//
//  Time.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class Time: NSObject, NSCoding {
    var time: NSTimeInterval!
	var dateRecorded: NSDate
	var comment: String?
    
    override init() {
        self.dateRecorded = NSDate.date()
    }
    
    required init(coder aDecoder: NSCoder!) {
        time = aDecoder.decodeObjectForKey("time") as NSTimeInterval
        dateRecorded = aDecoder.decodeObjectForKey("dateRecorded") as NSDate
        comment = aDecoder.decodeObjectForKey("comment") as String?
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(dateRecorded, forKey: "dateRecorded")
        aCoder.encodeObject(comment, forKey: "comment")
    }
    
    convenience init(time: NSTimeInterval, dateRecorded: NSDate) {
        self.init()
        self.time = time
        self.dateRecorded = dateRecorded
    }
}
