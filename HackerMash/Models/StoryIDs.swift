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
//class Article: Codable {
//    let source: Source
//    let author: String?
//    let title: String?
//    let description: String?
//    let url: String
//    var urlNewsLogo: String?
//    let urlToImage: String?
//    let publishedAt: String?
//
//    func setUrlNewsLogo(url: String) {
//        self.urlNewsLogo = url
//    }
//}
//
//class News: Codable {
//    let status: String
//    let totalResults: Int
//    let articles: [Article]
//}
//
//class Source: Codable {
//    let id: String?
//    let name: String?
//}

