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

    override func viewDidLoad() {
        super.viewDidLoad()

        challengeDataSource = ChallengeDataSource()
        challengeDataSource.addChallenge(Challenge(name: "Clap 20 Times"));
        challengeDataSource.addChallenge(Challenge(name: "Say the Alphabet"));
        challengeDataSource.addChallenge(Challenge(name: "100 Meter Sprint"));
        challengeDataSource.addChallenge(Challenge(name: "Read the CSCI342 A1 Spec"));
    }

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
}
