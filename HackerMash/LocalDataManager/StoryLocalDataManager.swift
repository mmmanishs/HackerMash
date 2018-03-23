//
//  StoryLocalDataManager.swift
//  HackerMash
//
//  Created by Manish Singh on 3/21/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Default
import Promises
class StoryLocalDataManager {
    func saveStories(promise: Promise<[Story]>, repo: DiskPath) {
        promise.then() { stories in
            let existingStories = self.getStories(repo: repo)
            let m = self.mergeStories(stories1: stories, stories2: existingStories)
            do {
                let data = try JSONEncoder().encode(m)
                try? data.write(to: repo.filepath())
            }
            
        }
    }
    
    func saveStories(stories: [Story], repo: DiskPath) {
        let existingStories = self.getStories(repo: repo)
        let m = self.mergeStories(stories1: stories, stories2: existingStories)
        do {
            let data = try? JSONEncoder().encode(m)
            try? data?.write(to: repo.filepath())
        }
    }
    
    func getStories(repo: DiskPath) -> [Story] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: repo.filepath())
            do {
                return try jsonDecoder.decode([Story].self, from: data)
            } catch {
                return []
            }
        } catch {
            return []
        }
    }
}

extension StoryLocalDataManager {
    func mergeStories(stories1: [Story], stories2: [Story]) -> [Story]{
        var m = [Story]()
        var s1 = stories1
        var s2 = stories2
        for i1 in s1 {
            for i2 in s2.reversed() {
                if i2.id == i1.id {
                    m.append(i1)
                    s1.remove(at: s1.index{$0 === i1}!)
                    s2.remove(at: s2.index{$0 === i2}!)
                }
            }
        }
        return m
    }
}
