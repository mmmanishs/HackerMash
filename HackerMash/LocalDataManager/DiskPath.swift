//
//  LocalFilePaths.swift
//  HackerMash
//
//  Created by Manish Singh on 3/22/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

enum DiskPath {
    case mainStory
    case favoriteStory
    case userStoryPref
    func filepath() -> URL{
        var filepath_mainStories: URL {
            let filepath_mainStories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return filepath_mainStories.appendingPathComponent("ms", isDirectory: false)
        }
        var filepath_favoriteStories: URL {
            let filepath_mainStories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return filepath_mainStories.appendingPathComponent("fs", isDirectory: false)
        }
        var filepath_userStoryPref: URL {
            let filepath_mainStories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return filepath_mainStories.appendingPathComponent("usp", isDirectory: false)
        }
        switch self {
        case .mainStory: return filepath_mainStories
        case .favoriteStory: return filepath_favoriteStories
        case .userStoryPref: return filepath_userStoryPref
        }
    }
}


