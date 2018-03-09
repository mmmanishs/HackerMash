//
//  StoryIdsDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
class StoryIdsDataManager {
    func getBestNewStoryIds() -> Promise<StoryIDs> {
        do {
            let bestStoriesUrl = try StoryIDsRequestProvider.bestStories.getRequest()
            return RemoteDataController().getStoriesID(url: bestStoriesUrl)
        }
        catch {
            return Promise<StoryIDs> { fullfil, reject in
                reject(ApiError.badURL)
            }
        }
        
    }
    
    func getTopNewStoryIds() -> Promise<StoryIDs> {
        do {
            let topStoriesUrl = try StoryIDsRequestProvider.topStories.getRequest()
            return RemoteDataController().getStoriesID(url: topStoriesUrl)
        }
        catch {
            return Promise<StoryIDs> { fullfil, reject in
                reject(ApiError.badURL)
            }
        }
        
    }

}