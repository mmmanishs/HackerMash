//
//  StoryIdsDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
class StoryDataManager {
    func getStory(forID id: Int) -> Promise<Story> {
        do {
            let storyURL = try StoryRequestProvider.story(id).getRequest()
            return RemoteDataController().getStory(url: storyURL)
        }
        catch {
            return Promise<Story> { fullfil, reject in
                reject(ApiError.badURL)
            }
        }
        
    }
}
