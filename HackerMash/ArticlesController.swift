//
//  MainArticlesViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
enum ControllerCommand<T> {
    case showLoading
    case showData(T)
}
protocol ViewModelInteractor {
    func updateView(command: ControllerCommand<ArticlesViewModel>)
}

class ArticlesController {
    var stories: [Story]?
    var ssRequested = 0
    var delegate: ViewModelInteractor?
    func getData() {
        ssRequested = 0
        let promsise = StoriesDataManager().getTopNews()
        self.delegate?.updateView(command: .showLoading)
        promsise.then(){ stories in
            self.stories = stories
            let viewModel = ArticlesViewModel(stories: stories)
            self.delegate?.updateView(command: .showData(viewModel))
            }.catch() {exception in
                print(exception.localizedDescription)
        }
    }
}

struct ArticlesViewModel {
    var rows: [ArticlesRowViewModel]
    init(stories: [Story]) {
        self.rows = [ArticlesRowViewModel]()
        stories.forEach(){ story in
            self.rows.append(ArticlesRowViewModel(title: story.title))
        }
    }
}

struct ArticlesRowViewModel {
    var title: String
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

