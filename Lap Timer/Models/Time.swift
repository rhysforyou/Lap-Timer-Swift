//
//  Time.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class Time {
	var time = 0.0
	var dateRecorded: NSDate
	var comment: String?

	init() {
		dateRecorded = NSDate.date()
	}
}
