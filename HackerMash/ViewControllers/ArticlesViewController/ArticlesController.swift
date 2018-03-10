//
//  MainArticlesViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
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
    var viewModel = ArticlesViewModel(title: "Top Stories")
    let localDataManager = LocalDataManager()
    
    func getData() {
        self.delegate?.updateView(viewModel: self.viewModel, command: .showLoading)
        let promise = StoriesDataManager().getTopNews()
        promise.then(){ stories in
            self.stories = stories
            self.viewModel.update(withStories: stories)
            self.delegate?.updateView(viewModel: self.viewModel, command: .showData)
            }.catch() {exception in
                self.delegate?.updateView(viewModel: self.viewModel, command: .showError)
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
        stories.forEach(){ story in
            self.rows.append(ArticlesRowViewModel(
                id: story.id,
                timeStamp: story.time,
                title: story.title,
                time:story.getTimeAgo(),
                isRead:localDataManager.isIDMarkedAsRead(id: story.id)
            ))
            self.rows = self.rows.sorted() {a,b in
                a.timeStamp > b.timeStamp
            }
        }

    }
}

struct ArticlesRowViewModel {
    var id: Int
    var timeStamp: Int64
    var title: String
    var time: String
    var isRead: Bool
}

