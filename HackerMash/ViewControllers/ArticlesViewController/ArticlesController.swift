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
    case bestStories
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
    var stories: [Story]?
    var delegate: ViewModelInteractor?
    let localDataManager = LocalDataManager()
    
    func getData(articlesType: ArticleType) {
        var viewModel: ArticlesViewModel
        var promise: Promise<[Story]>?
        switch articlesType {
        case .topStories:
            promise = StoriesDataManager().getTopNews()
            viewModel = ArticlesViewModel(title: "Top Stories")
        case .bestStories:
            promise = StoriesDataManager().getBestNews()
            viewModel = ArticlesViewModel(title: "Best Stories")
        case .savedStories:
            viewModel = ArticlesViewModel(title: "Saved Stories")
            break
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

struct ArticlesViewModel {
    var rows: [ArticlesRowViewModel]
    var title: String
    let localDataManager = LocalDataManager()

    init(title: String) {
        self.title = title
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
                isRead:localDataManager.isIDMarkedAsRead(id: story.id),
                url: story.url
            ))
        }

    }
}

struct ArticlesRowViewModel {
    var id: Int
    var timeStamp: Int64
    var title: String
    var time: String
    var isRead: Bool
    var url: String
}

