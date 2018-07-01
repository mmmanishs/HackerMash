//
//  StoryLocalDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 3/21/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//
//Need to store time stamp of last save
import Foundation
import Promises
class LocalDataManagerStory {
    func updateStoryDB(promise: Promise<[Story]>) {
        promise.then() { stories in
            let sd = self.read(repo: DiskPath.topStoryArchives)
            sd.date = Date()
            merge(old: &sd.stories, new: stories)
            do {
                let data = try JSONEncoder().encode(sd)
                try? data.write(to: DiskPath.topStoryArchives.filepath())
            }
            
        }
    }
    
    func saveBatchOfStories(promise: Promise<[Story]>) {
        promise.then() { stories in
            let storyDisk = StoryDisk(date: Date(), stories: stories)
            do {
                let data = try JSONEncoder().encode(storyDisk)
                try? data.write(to: DiskPath.topStory.filepath())
            }
        }
    }
    
    func saveStories(stories: [Story], repo: DiskPath) {
        let sd = self.read(repo: repo)
        sd.date = Date()
        merge(old: &sd.stories, new: stories)
        do {
            let data = try? JSONEncoder().encode(sd)
            try? data?.write(to: repo.filepath())
        }
    }
    
    func read(repo: DiskPath) -> StoryDisk {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: repo.filepath())
            do {
                return try jsonDecoder.decode(StoryDisk.self, from: data)
            } catch {
                return StoryDisk(date: Date(), stories: [])
            }
        } catch {
            return StoryDisk(date: Date(), stories: [])
        }
    }
}

class StoryDisk: Codable {
    var date: Date
    var stories: [Story]
    init(date: Date, stories: [Story]) {
        self.date = date
        self.stories = stories
    }
}
