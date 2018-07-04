//
//  ArticleViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 7/4/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
struct ArticlesViewModel {
    var rows: [ArticlesRowViewModel]
    let localDataManager = LocalDataManagerFavorites()
    
    init() {
        self.rows = [ArticlesRowViewModel]()
    }
    
    mutating func update(withStories stories: [Story]) {
        self.rows.removeAll()
        stories.forEach(){ story in
            self.rows.append(ArticlesRowViewModel(
                id: story.id,
                timeStamp: story.time,
                title: story.title,
                time:story.getTimeAgo(),
                url: story.url, story: story,
                usp: (localDataManager.getFavorite(id: story.id)
            )))
        }
    }
}

class ArticlesRowViewModel {
    var id: Int
    var timeStamp: Int64
    var title: String
    var time: String
    var url: String
    var story: Story
    var favorite: Favorite
    init(id: Int,
         timeStamp: Int64,
         title: String,
         time: String,
         url: String,
         story: Story,
         usp: Favorite) {
        self.id = id
        self.timeStamp = timeStamp
        self.title = title
        self.time = time
        self.url = url
        self.story = story
        self.favorite = usp
    }
}


