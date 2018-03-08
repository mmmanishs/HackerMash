//
//  MainArticlesViewModel.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
protocol CanBeMainViewModel {
    
}
class MainArticlesViewModel: CanBeMainViewModel {
    var rows = [MainTableRowViewModel]()
    var ssRequested = 0
    func getData(completion: @escaping (Bool)-> ()) {
        ssRequested = 0
        let promsise = DataManager().getBestNewStories()
        promsise.then(){ storiesID in
            guard let ids = storiesID.ids else {
                completion(false)
                return
            }
            for id in ids {
                StoryDataManager().getStory(forID: id).then() { story in
                    self.rows.append(MainTableRowViewModel(title: story.title))
                    self.ssRequested = self.ssRequested + 1
                    print("\(self.ssRequested) == \(ids.count)")
                    if self.ssRequested ==  ids.count {
                        completion(true)
                    }

                    }.catch() { error in
                        print(error.localizedDescription)
                        self.ssRequested = self.ssRequested + 1
                        print("\(self.ssRequested) == \(ids.count)")
                        if self.ssRequested ==  ids.count {
                            completion(true)
                        }
                }
            }
            
            }.catch() {exception in
                print(exception.localizedDescription)
                completion(false)
        }
    }
}

struct MainTableRowViewModel {
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

