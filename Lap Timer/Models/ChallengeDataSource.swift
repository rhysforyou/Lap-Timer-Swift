//
//  ChallengeDataSource.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class ChallengeDataSource: NSObject, UITableViewDataSource {
	private var challenges: [Challenge] = []

	func addChallenge(challenge: Challenge) {
		challenges.append(challenge)
	}

	func challengeAtIndex(index: Int) -> Challenge {
		return challenges[index]
	}

	func numberOfChallenges() -> Int {
		return challenges.count
	}

	// MARK: - TableView

	func tableView(tableView: UITableView!,
		cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell {
			return UITableViewCell()
	}

	func tableView(tableView: UITableView!,
		numberOfRowsInSection section: Int) -> Int {
			return numberOfChallenges()
	}
}
