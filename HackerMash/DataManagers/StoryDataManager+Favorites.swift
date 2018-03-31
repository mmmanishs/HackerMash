//
//  StoryDataManager+Favorites.swift
//  HackerMash
//
//  Created by Manish Singh on 3/23/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

extension StoryDataManager {
    func getFavorites() -> [Story] {
        let favorites = LocalDataManagerFavorites().read().favorites
        let bs = LocalDataManagerStory().read(repo: .bestStory)
        let ts = LocalDataManagerStory().read(repo: .topStory)
        let data = merge(array1: bs.stories, array2: ts.stories)
        var favoriteStories = [Story]()
        for favorite in favorites {
            for story in data {
                if story.id == favorite.id {
                    favoriteStories.append(story)
                    break
                }
            }
        }
        return favoriteStories
    }
}

