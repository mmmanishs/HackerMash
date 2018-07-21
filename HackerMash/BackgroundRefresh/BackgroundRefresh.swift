//
//  BackgroundRefresh.swift
//  HackerMash
//
//  Created by Manish Singh on 7/1/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import DLLocalNotifications

class BackgroundRefresh {
    var backgroundTaskIdentifier = UIBackgroundTaskInvalid

    func backgroundRefresh() {
        guard startBackgroundTask() else { return }
        let downloadedStories = StoryDataManager().getDownloadedStoriesPromise()
        DispatchQueue.global(qos: .background).async {
            LocalDataManagerStory().updateStoryArchive(promise: downloadedStories)
            LocalDataManagerStory().saveBatchOfStories(promise: downloadedStories)
        }
        downloadedStories.then() { stories in
            let existingStories = LocalDataManagerStory().read(repo: .topStoryArchives).stories
            
            let downloadedSet = Set(stories)
            let existingSet = Set(existingStories)
            let newStories = downloadedSet.subtracting(existingSet)
            if let notficationProperties = self.getNotificationProperties(stories: newStories) {
                self.localNotificationScheduler(notificationProperties: notficationProperties)
            }
            AppData.updateLastStoriesDownloadedTime(date: Date())
            self.endBackgroundTask()
        }
    }
    
    func localNotificationScheduler(notificationProperties: NotificationProperties) {
        // The date you would like the notification to fire at
        
        let notification = DLNotification(identifier: notificationProperties.identifier, alertTitle: notificationProperties.alertTitle, alertBody: notificationProperties.alertBody, date: notificationProperties.date, repeats: .None)
        
        let scheduler = DLNotificationScheduler()
        _ = scheduler.scheduleNotification(notification: notification)
    }
    
    func getNotificationProperties(stories: Set<Story>) -> NotificationProperties? {
        let date = Date() + 5.0
        switch stories.count {
        case 0:
            return nil
        case 1:
            if let story = stories.randomElement() {
                return NotificationProperties(alertTitle: "Top Story", identifier: getIdentifier(stories: stories), alertBody: story.title, date: date)
            }
        case 2...Int.max:
            if let story = stories.randomElement() {
                return NotificationProperties(alertTitle: "\(stories.count) new stories", identifier: getIdentifier(stories: stories), alertBody: story.title, date: date)
            }
        default:
            break
        }
        return nil
    }
    
    func getIdentifier(stories: Set<Story>) -> String {
        let userdefaults = UserDefaults.standard
        if stories.count == 1,
            let story = stories.first {
            return "\(story.id)"
        }
        var counter = 0
        if let counterValueFromDefaults = userdefaults.value(forKey: AppData.localNotificationsKey) as? Int {
            counter = counterValueFromDefaults
        }
        return "counterValueFromDefaults \(counter)"
    }
}

extension BackgroundRefresh {
    
    private func startBackgroundTask() -> Bool {
        guard backgroundTaskIdentifier == UIBackgroundTaskInvalid  else { return false }
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask() {
            self.endBackgroundTask()
        }
        return backgroundTaskIdentifier != UIBackgroundTaskInvalid
    }
    
    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        backgroundTaskIdentifier = UIBackgroundTaskInvalid
    }
}
struct NotificationProperties {
    let alertTitle: String
    let identifier: String
    let alertBody: String
    let date: Date
}
