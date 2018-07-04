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
    case archives
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
    var delegate: ViewModelInteractor?
    let localDataManagerFavorites = LocalDataManagerFavorites()
    
    func getData(articlesType: ArticleType) {
        var viewModel: ArticlesViewModel
        var promise: Promise<[Story]>?
        viewModel = ArticlesViewModel()
        self.delegate?.updateView(viewModel: viewModel, command: .showLoading)
        switch articlesType {
        case .topStories:
            promise = StoryDataManager().getTop()
        case .savedStories:
            viewModel.update(withStories: StoryDataManager().getFavorites())
            self.delegate?.updateView(viewModel: viewModel, command: .showData)
            return
        case .archives:
            promise = StoryDataManager().getArchives()
        }
        promise?.then(){ stories in
            viewModel.update(withStories: stories.sorted { s1, s2 in
                return s1.time > s2.time
            })
            self.delegate?.updateView(viewModel: viewModel, command: .showData)
            }.catch() {exception in
                self.delegate?.updateView(viewModel: viewModel, command: .showError)
        }
    }
}

