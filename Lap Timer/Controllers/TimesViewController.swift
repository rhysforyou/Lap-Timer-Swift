//
//  TimesViewController.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class TimesViewController: UITableViewController {
    var challenge: Challenge!
    var dateFormatter: NSDateFormatter!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm:ss:S"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return challenge.times.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let time = challenge.times[indexPath.row]

        cell.textLabel.text = time.comment
        cell.detailTextLabel.text = formatTimeInterval(time.time)

        return cell
    }
    
    
    // MARK: - Utility Methods
    
    func formatTimeInterval(interval: NSTimeInterval) -> String {
        let intervalAsDate = NSDate(timeIntervalSince1970: interval)
        return dateFormatter.stringFromDate(intervalAsDate)
    }
}
