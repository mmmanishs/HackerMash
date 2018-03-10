//
//  Story.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Default

final class Story: Codable, DefaultStorable {
    let by: String
    let descendants: Int
    let id: Int
    let kids: [Int]
    let score: Int
    let time: Int64
    let title: String
    let type: String
    let url: String

    func getTimeAgo() -> String {
        let publish = Date.init(timeIntervalSince1970: TimeInterval(time))
        let timeInSecs = Date().timeIntervalSince(publish)
        let timeInHrs = Int(timeInSecs / 3600)
        switch true {
        case (timeInHrs > 24) && (timeInHrs < 48):
            return "\(timeInHrs / 24) day ago"
        case (timeInHrs > 48):
            return "\(timeInHrs / 24) days ago"
        case (timeInHrs > 168) && (timeInHrs < 336):
            return "\(timeInHrs / 24) week ago"
        case timeInHrs > 336:
            return "\(timeInHrs / 168) weeks ago"
        default:
            return "\(timeInHrs) hrs"
        }
    }
    
    func printDescription() {
        print("by : \(by)")
        print("descendants : \(descendants)")
        print("id : \(id)")
        print("kids : \(kids)")
        print("score : \(score)")
        print("time : \(time)")
        print("title : \(title)")
        print("type : \(type)")
        print("url : \(type)")
    }
}

/*
 by : matant
 descendants : 222
 id : 16493489
 kids : [16494238, 16494265, 16494014, 16495866, 16496703, 16496534, 16493736, 16494203, 16499240, 16494555, 16495966, 16497471, 16528936, 16499452, 16495248, 16495423, 16494145, 16498112, 16495843, 16494700, 16495012, 16494188, 16498680, 16499687, 16494124, 16494646, 16499960, 16494329, 16496972, 16500696, 16499649, 16499326, 16494398, 16496992, 16494499, 16495267, 16494103, 16499465]
 score : 1919
 time : 1519922390
 title : Machine Learning Crash Course
 type : story
 */
