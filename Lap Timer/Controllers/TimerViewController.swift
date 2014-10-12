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
    var currentTime: NSTimeInterval = 0.0
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerToggleButton: UIButton!
    @IBOutlet var bestTimeBar: UIProgressView!
    @IBOutlet var bestTimeLabel: UILabel!
    @IBOutlet var worstTimeBar: UIProgressView!
    @IBOutlet var worstTimeLabel: UILabel!
    @IBOutlet var averageTimeBar: UIProgressView!
    @IBOutlet var averageTimeLabel: UILabel!
    @IBOutlet var currentTimeBar: UIProgressView!
    @IBOutlet var currentTimeLabel: UILabel!
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        updateTimers()
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
                selector: Selector("updateTimers"), userInfo: nil, repeats: true)
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
            currentTime = 0.0
            timerToggleButton.setTitle("Start", forState: .Normal)
            timerState = .Stopped
            updateTimers()
        }
	}
    
    
    // Mark: - Timer
    
    func updateTimers() {
        let bestTime = challenge?.bestTime()
        let worstTime = challenge?.worstTime()
        let averageTimeInterval = challenge?.averageTime()
        
        if timerState == .Running {
            currentTime = NSDate.date().timeIntervalSinceDate(timerStartDate!)
        }
        
        var maxTime: NSTimeInterval
        
        if timerState == .Running {
            if let worstTimeInterval = worstTime?.time {
                maxTime = max(worstTimeInterval, currentTime)
            } else {
                maxTime = currentTime
            }
        } else {
            if let worstTimeInterval = worstTime?.time {
                maxTime = worstTimeInterval
            } else {
                maxTime = 100.0
            }
        }
    
        timerLabel.text = formatTimeInterval(currentTime)
        currentTimeLabel.text = formatTimeInterval(currentTime)
        currentTimeBar.progress = Float(currentTime / maxTime)
        
        if let bestTimeInterval = bestTime?.time {
            bestTimeLabel.text = "\(bestTime!.comment!)   \(formatTimeInterval(bestTimeInterval))"
            bestTimeBar.progress = Float(bestTimeInterval / maxTime)
        } else {
            bestTimeLabel.text = formatTimeInterval(0.0)
            bestTimeBar.progress = 0.0
        }
        
        if let worstTimeInterval = worstTime?.time {
            worstTimeLabel.text = "\(worstTime!.comment!)   \(formatTimeInterval(worstTimeInterval))"
            worstTimeBar.progress = Float(worstTimeInterval / maxTime)
        } else {
            worstTimeLabel.text = formatTimeInterval(0.0)
            worstTimeBar.progress = 0.0
        }
        
        if let average = averageTimeInterval {
            averageTimeLabel.text = formatTimeInterval(average)
            averageTimeBar.progress = Float(average / maxTime)
        } else {
            averageTimeLabel.text = formatTimeInterval(0.0)
            averageTimeBar.progress = 0.0
        }
    }

    func displaySaveDialog() {
        let alertController = UIAlertController(title: "Save Time",
            message: "Please enter an optional coment", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) in
            let time = Time()
            time.time = self.currentTime
            
            if let commentField = alertController.textFields?.first as? UITextField {
                time.comment = commentField.text
            }
            
            self.challenge?.addTime(time)
            self.updateTimers()
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
    
    func formatTimeInterval(interval: NSTimeInterval) -> String {
        let intervalAsDate = NSDate(timeIntervalSince1970: interval)
        return dateFormatter.stringFromDate(intervalAsDate)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showTimes" {
            let navigationController = segue.destinationViewController as UINavigationController
            let timesViewController = navigationController.topViewController as TimesViewController
            timesViewController.challenge = challenge
        }
    }

	@IBAction func unwindToTiemrViewController(segue: UIStoryboardSegue) {}
}
