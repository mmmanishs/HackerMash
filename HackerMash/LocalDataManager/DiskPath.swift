//
//  LocalFilePaths.swift
//  HackerMash
//
//  Created by Manish Singh on 3/22/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

enum DiskPath {
    case topStory
    case favoriteStory
    case userStoryPref
    case topStoryArchives
    func filepath() -> URL{
        var filepath_topStories: URL {
            let filepath_topStories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return filepath_topStories.appendingPathComponent("tops", isDirectory: false)
        }
        var filepath_topStoryCumulative: URL {
            let filepath_topStories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return filepath_topStories.appendingPathComponent("filepath_topStoryCumulative", isDirectory: false)
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
        case .topStory: return filepath_topStories
        case .topStoryArchives: return filepath_topStoryCumulative
        case .favoriteStory: return filepath_favoriteStories
        case .userStoryPref: return filepath_userStoryPref
        }
    }
}


