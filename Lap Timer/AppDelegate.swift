//
//  AppDelegate.swift
//  Lap Timer
//
//  Created by Rhys Powell on 5/08/2014.
//  Copyright (c) 2014 Rhys Powell. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
	var window: UIWindow?
    var challengeDataSource: ChallengeDataSource?


	func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
		UINavigationBar.appearance().barTintColor = UIColor(red: 69.0/255.0, green: 48.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        
        let navigationController = self.window?.rootViewController as UINavigationController
        let challengesController = navigationController.topViewController as ChallengesViewController
        
        unarchiveDataSource()
        
        if let dataSource = challengeDataSource {
            challengesController.challengeDataSource = dataSource
        } else {
            loadDefaultChallenges()
            challengesController.challengeDataSource = challengeDataSource
        }
        
		return true
	}

    func applicationWillResignActive(application: UIApplication) {
        archiveDataSource()
    }
    
    func archiveDataSource() {
        if NSKeyedArchiver.archiveRootObject(challengeDataSource!, toFile: archivePath()) {
            println("File saved")
        } else {
            println("Something went wrong")
        }
    }
    
    func unarchiveDataSource() {
        challengeDataSource = NSKeyedUnarchiver.unarchiveObjectWithFile(archivePath()) as? ChallengeDataSource
    }
    
    func archivePath() -> String {
        let fileManager = NSFileManager.defaultManager()
        let archivePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        return "\(archivePath)/Challenges.archive"
    }
    
    func loadDefaultChallenges() {
        challengeDataSource = ChallengeDataSource()
        challengeDataSource?.addChallenge(Challenge(name: "Clap 20 Times"));
        challengeDataSource?.addChallenge(Challenge(name: "Say the Alphabet"));
        challengeDataSource?.addChallenge(Challenge(name: "100 Meter Sprint"));
        challengeDataSource?.addChallenge(Challenge(name: "Read the CSCI342 A1 Spec"));
    }
}

