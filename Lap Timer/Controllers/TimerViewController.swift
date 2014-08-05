//
//  TimerViewController.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    enum TimerState {
        case Stopped
        case Running
        case Finished
    }
    
	var challenge: Challenge?
    
    var timerState: TimerState = .Stopped
    var timer: NSTimer?
    var timerStartDate: NSDate?
    var dateFormatter: NSDateFormatter!
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerToggleButton: UIButton!
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		challenge = Challenge(name: "Test")
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm:ss:S"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
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
        switch timerState {
        case .Stopped:
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self,
                selector: Selector("updateTimer"), userInfo: nil, repeats: true)
            timerStartDate = NSDate.date()
            
            timerToggleButton.setTitle("Stop", forState: .Normal)
            timerState = .Running
            
        case .Running:
            timer?.invalidate()
            timer = nil
            
            displaySaveDialog()
            
            timerToggleButton.setTitle("Clear", forState: .Normal)
            timerState = .Finished
            
        case .Finished:
            timerLabel.text = "00:00:0"
            
            timerToggleButton.setTitle("Start", forState: .Normal)
            timerState = .Stopped
        }
	}
    
    
    // Mark: - Timer
    
    func updateTimer() {
        let timeElapsed = NSDate.date().timeIntervalSinceDate(timerStartDate)
        let elapsedDate = NSDate(timeIntervalSince1970: timeElapsed)
        
        timerLabel.text = dateFormatter.stringFromDate(elapsedDate)
    }
    
    func recordTime() {
    }

    func displaySaveDialog() {
        let alertController = UIAlertController(title: "Save Time",
            message: "Please enter an optional coment", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) in
            let time = Time()
            time.time = NSDate.date().timeIntervalSinceDate(self.timerStartDate)
            
            if let commentField = alertController.textFields[0] as? UITextField {
                time.comment = commentField.text
            }
            
            self.challenge?.addTime(time)
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action: UIAlertAction!) in
            println("Dismiss")
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = "Comment"
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
