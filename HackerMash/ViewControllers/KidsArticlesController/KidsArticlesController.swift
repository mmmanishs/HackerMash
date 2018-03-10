//
//  MainArticlesViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class KidsArticlesController {
    var stories: [Story]?
    var delegate: ViewModelInteractor?
    var viewModel = ArticlesViewModel(title: "Kids details")
    var storyIds: [Int]
    
    init(storyIds:[Int]) {
        self.storyIds = storyIds
    }
    
    func getData() {
        self.delegate?.updateView(viewModel: self.viewModel, command: .showLoading)
        
        let promise = KidsDataManager().getKidsNews(ids: storyIds)
        promise.then(){ stories in
            self.stories = stories
            self.viewModel.update(withStories: stories)
            self.delegate?.updateView(viewModel: self.viewModel, command: .showData)
            }.catch() {exception in
                self.delegate?.updateView(viewModel: self.viewModel, command: .showError)
        }
    }
}
