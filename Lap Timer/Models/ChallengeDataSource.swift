//
//  ChallengeDataSource.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

class ChallengeDataSource: NSObject, NSCoding {
	private var challenges: [Challenge]
    
    override init() {
        challenges = []
    }
    
    required init(coder: NSCoder) {
        challenges = coder.decodeObjectForKey("challenges") as [Challenge]
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(challenges, forKey: "challenges")
    }

	func addChallenge(challenge: Challenge) {
		challenges.append(challenge)
	}

	func challengeAtIndex(index: Int) -> Challenge {
		return challenges[index]
	}

	func numberOfChallenges() -> Int {
		return challenges.count
	}
}
