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
}

protocol ViewModelInteractor {

    func updateView(viewModel: ArticlesViewModel, command: ControllerCommand)
}

class ArticlesController {
    var stories: [Story]?
    var delegate: ViewModelInteractor?
    var viewModel = ArticlesViewModel(title: "Top Stories")
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
    init(title: String) {
        self.title = title
        self.rows = [ArticlesRowViewModel]()
    }
    
    mutating func update(withStories stories: [Story]) {
        stories.forEach(){ story in
            self.rows.append(ArticlesRowViewModel(
                title: story.title,
                time:story.getTimeAgo()
            ))
        }

    }
}

struct ArticlesRowViewModel {
    var title: String
    var time: String
}

//class MainTableRowViewModelBuilder {
//    let stories: [Story]
//    init(stories: [Story]) {
//        self.stories = stories
//    }
//    func build() -> [MainTableRowViewModel] {
//        var rows = [MainArticlesViewModel]()
//        for story in stories {
//            rows.append(MainTableRowViewModel(title: story.title))
//        }
//        return rows
//    }
//}

