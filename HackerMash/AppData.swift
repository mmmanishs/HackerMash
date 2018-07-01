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
    static let downloadIntervalInSeconds: TimeInterval = 10000
    static func shouldDownloadNewStories() -> Bool {
        let userdefaults = UserDefaults.standard
        if let downloadedDate = userdefaults.value(forKey: downloadedTimeKey) as? Date {
            let storiesExpiryDate = Date(timeInterval: downloadIntervalInSeconds, since: downloadedDate)
            return Date() > storiesExpiryDate
        }
        return true
    }
    
    static func storiesDownloaded() {
        let userdefaults = UserDefaults.standard
        userdefaults.set(Date(), forKey: downloadedTimeKey)
        userdefaults.synchronize()
    }
}
