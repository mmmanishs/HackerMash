//
//  MainArticlesViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
enum ArticleType {
    case topStories
    case savedStories
}

enum ControllerCommand {
    case initialSetup
    case showLoading
    case showData
    case showError
    case progress(Float)
}

protocol ViewModelInteractor {

    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand)
}

class ArticlesController {
    private var stories: [Story]?
    var delegate: ViewModelInteractor?
    let favoriteLocalDataManager = LocalDataManagerFavorites()
    
    func getData(articlesType: ArticleType) {
        var viewModel: ArticlesViewModel
        var promise: Promise<[Story]>?
        switch articlesType {
        case .topStories:
            promise = StoryDataManager().getTop()
            viewModel = ArticlesViewModel(title: "Top Stories")
        case .savedStories:
            viewModel = ArticlesViewModel(title: "Saved Stories")
            viewModel.update(withStories: StoryDataManager().getFavorites())
            self.delegate?.updateView(viewModel: viewModel, command: .showData)
            return
        }
        self.delegate?.updateView(viewModel: viewModel, command: .showLoading)
        promise?.then(){ stories in
            self.stories = stories
            viewModel.update(withStories: stories)
            self.delegate?.updateView(viewModel: viewModel, command: .showData)
            }.catch() {exception in
                self.delegate?.updateView(viewModel: viewModel, command: .showError)
        }
    }
}

class ArticlesViewModel {
    var rows: [ArticlesRowViewModel]
    var title: String
    let localDataManager = LocalDataManagerFavorites()

    init(title: String) {
        self.title = title
        self.rows = [ArticlesRowViewModel]()
    }
    
    func update(withStories stories: [Story]) {
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


