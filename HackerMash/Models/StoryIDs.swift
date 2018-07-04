//
//  Article.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class StoryIDs: Codable {
    let ids: [Int]?
    init(ids: [Int]) {
        self.ids = ids
    }
}
