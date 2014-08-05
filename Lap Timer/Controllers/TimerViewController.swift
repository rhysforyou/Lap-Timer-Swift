//
//  TimerViewController.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
	var challenge: Challenge?
    
    var timerRunning: Bool = false
    var timer: NSTimer?
    var timerStartDate: NSDate?
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerToggleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

		challenge = Challenge(name: "Test")
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if let c = challenge {
			navigationItem.title = c.name
		} else {
			navigationItem.title = "Challenge"
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	// MARK: - Interface Actions

	@IBAction func toggleTimer(sender: AnyObject) {
        if (!timerRunning) {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self,
                selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            timerStartDate = NSDate.date()
            timerToggleButton.setTitle("Stop", forState: .Normal)
        } else {
            timer?.invalidate()
            timer = nil
            timerToggleButton.setTitle("Start", forState: .Normal)
        }
        
        timerRunning = !timerRunning
	}
    
    // Mark: - Timer
    
    func updateTimer() {
        let timeElapsed = NSDate.date().timeIntervalSinceDate(timerStartDate)
        let elapsedDate = NSDate(timeIntervalSince1970: timeElapsed)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "mm:ss:S"
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        timerLabel.text = formatter.stringFromDate(elapsedDate)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	@IBAction func unwindToTiemrViewController(segue: UIStoryboardSegue) {
		
	}
}
