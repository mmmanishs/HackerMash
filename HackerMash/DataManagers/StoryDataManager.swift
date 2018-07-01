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
            let downloadedPromises = getDownloadedStroriesPromise()
            downloadedPromises.then{ _ in
                AppData.storiesDownloaded()
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
        return Promise(LocalDataManagerStory().read(repo: .topStoryCumulative).stories)
    }
    
    func getDownloadedStroriesPromise() -> Promise<[Story]> {
        let sPromise = Promise<[Story]>(on:.global()) { fullfil, reject in
            let idsPromise = StoryIdsDataManager().getTopNewStoryIds()
            idsPromise.then(){ storiesID in
                guard let ids = storiesID.ids else {
                    reject(ApiError.apiError)
                    return
                }
                var processedCount = 0
                var stories = [Story]()
                for id in ids {
                    self.getStory(forID: id).then() { story in
                        stories.append(story)
                        }.catch() { error in
                        }.always {
                            processedCount = processedCount + 1
                            if processedCount == ids.count {
                                fullfil(stories)
                            }
                    }
                }
                }.catch() {error in
                    reject(error)
            }
        }
        DispatchQueue.global(qos: .background).async {
            LocalDataManagerStory().updateStoryDB(promise: sPromise)
            LocalDataManagerStory().saveBatchOfStories(promise: sPromise)
        }
        return sPromise
    }
}

extension StoryDataManager {
    func getStory(forID id: Int) -> Promise<Story> {
        do {
            let storyURL = try StoryRequestProvider.story(id).getRequest()
            return RemoteDataController().getStory(url: storyURL)
        }
        catch {
            return Promise(ApiError.badURL)
        }
    }
}
