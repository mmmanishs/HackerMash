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
        let ts = LocalDataManagerStory().read(repo: .topStory)
        let data = ts.stories
        var favoriteStories = [Story]()
        for favorite in favorites {
            for story in data {
                if story.id == favorite.id && favorite.isSaved == true {
                    favoriteStories.append(story)
                    break
                }
            }
        }
        return favoriteStories
    }
}

