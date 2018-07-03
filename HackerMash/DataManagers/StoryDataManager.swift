//
//  StoriesDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises

class StoryDataManager {
    func getTop() -> Promise<[Story]> {
        if AppData.shouldDownloadNewStories() {
            let downloadedPromises = getDownloadedStoriesPromise()
            downloadedPromises.then{ _ in
                AppData.updateLastStoriesDownloadedTime(date: Date())
            }
            DispatchQueue.global(qos: .background).async {
                LocalDataManagerStory().updateStoryDB(promise: downloadedPromises)
                LocalDataManagerStory().saveBatchOfStories(promise: downloadedPromises)
            }
            return downloadedPromises
        } else {
            return Promise(LocalDataManagerStory().read(repo: .topStory).stories)
        }
    }
    
    func getArchives() -> Promise<[Story]> {
        return Promise(LocalDataManagerStory().read(repo: .topStoryArchives).stories)
    }
    
    func getDownloadedStoriesPromise() -> Promise<[Story]> {
        let sPromise = Promise<[Story]>(on:.global()) { fullfil, reject in
            let idsPromise = StoryIdsDataManager().getTopNewStoryIds()
            idsPromise.then(){ storiesID in
                guard let ids = storiesID.ids else {
                    reject(ApiError.apiError)
                    return
                }
                RemoteStoriesFetch().getStoriesPromise(for: ids).then() { stories in
                    fullfil(stories)
                }
                }.catch() {error in
                    reject(error)
            }
        }
        return sPromise
    }
}
