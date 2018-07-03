//
//  AppData.swift
//  HackerMash
//
//  Created by Manish Singh on 7/1/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class AppData {
    static let downloadedTimeKey = "lastDownloadedStoriesTime"
    static let downloadIntervalInSeconds: TimeInterval = 7200
    static let localNotificationsKey = "hacker_mash_local_notifications_counter"
    static let minimumBackgroundFetchInterval = 3600.0
    static let enableMockTools = true

    static func shouldDownloadNewStories() -> Bool {
        let userdefaults = UserDefaults.standard
        if let downloadedDate = userdefaults.value(forKey: downloadedTimeKey) as? Date {
            let storiesExpiryDate = Date(timeInterval: downloadIntervalInSeconds, since: downloadedDate)
            return Date() > storiesExpiryDate
        }
        return true
    }
    
    static func updateLastStoriesDownloadedTime(date: Date) {
        let userdefaults = UserDefaults.standard
        userdefaults.set(date, forKey: downloadedTimeKey)
        userdefaults.synchronize()
    }
}
