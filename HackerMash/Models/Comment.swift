//
//  Comment.swift
//  HackerMash
//
//  Created by Manish Singh on 3/10/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
class Comment: Codable {
    let by: String
    let parent: Int
    let id: Int
    let kids: [Int]
    let text: String
    let time: Int64
    let type: String
}
