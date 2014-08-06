//
//  ChallengesViewController.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class ChallengesViewController: UITableViewController {
    var challengeDataSource: ChallengeDataSource!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return challengeDataSource.numberOfChallenges()
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let challenge = challengeDataSource.challengeAtIndex(indexPath.row)
        cell.textLabel.text = challenge.name

        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.performSegueWithIdentifier("showTimerView", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "showTimerView" {
            let timerView = segue.destinationViewController as TimerViewController
            timerView.challenge = challengeDataSource.challengeAtIndex(tableView.indexPathForSelectedRow().row)
        }
    }
    
    // MARK: - Interface Actions
    
    @IBAction func createChallenge(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Challenge",
            message: "Please enter a name for this challenge",
            preferredStyle: .Alert)
        
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action: UIAlertAction!) in
            if let nameField = alertController.textFields[0] as? UITextField {
                let challenge = Challenge(name: nameField.text)
                self.challengeDataSource.addChallenge(challenge)
                
                let newRowIndexPath = NSIndexPath(forRow: self.challengeDataSource.numberOfChallenges() - 1, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([newRowIndexPath], withRowAnimation: .Automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = "Name"
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
