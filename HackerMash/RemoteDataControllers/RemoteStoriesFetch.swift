//
//  RemoteStoriesFetch.swift
//  HackerMash
//
//  Created by Manish Singh on 7/1/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Promises

class RemoteStoriesFetch {
    func getStoriesPromise(for ids: [Int]) -> Promise<[Story]> {
        return Promise<[Story]>(on:.global()) { fullfil, reject in
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
        }
    }
    
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
