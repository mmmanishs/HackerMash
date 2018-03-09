//
//  StoriesDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
class StoriesDataManager {
    func getBestNews() -> Promise<[Story]> {
        let sPromise = Promise<[Story]> { fullfil, reject in
            let idsPromise = StoryIdsDataManager().getBestNewStoryIds()
            idsPromise.then(){ storiesID in
                guard let ids = storiesID.ids else {
                    reject(ApiError.apiError)
                    return
                }
                var processedCount = 0
                var stories = [Story]()
                for id in ids {
                    StoryStoryIdsDataManager().getStory(forID: id).then() { story in
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
        return sPromise
    }
    //TODO: Make all the promises execute on background threads
    
    func getTopNews() -> Promise<[Story]> {
        let sPromise = Promise<[Story]> { fullfil, reject in
            let idsPromise = StoryIdsDataManager().getTopNewStoryIds()
            idsPromise.then(){ storiesID in
                guard let ids = storiesID.ids else {
                    reject(ApiError.apiError)
                    return
                }
                var processedCount = 0
                var stories = [Story]()
                for id in ids {
                    StoryStoryIdsDataManager().getStory(forID: id).then() { story in
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
        return sPromise
    }
}

class KidsDataManager {
    func getKidsNews(ids: [Int]) -> Promise<[Story]> {
        let sPromise = Promise<[Story]> { fullfil, reject in
            var processedCount = 0
            var stories = [Story]()
            for id in ids {
                StoryStoryIdsDataManager().getStory(forID: id).then() { story in
                    stories.append(story)
                    }.catch() { error in
                    }.always {
                        processedCount = processedCount + 1
                        if processedCount == ids.count {
                            fullfil(stories)
                        }
                }
            }
        }
        return sPromise
    }
}

