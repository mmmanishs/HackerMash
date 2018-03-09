//
//  StoryRequestProvider.swift
//  HackerMash
//
//  Created by Manish Singh on 3/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

enum StoryRequestProvider: RequestProvider {
    
    case story(Int)
    func getRequest() throws -> URLRequest {
        do {
            switch self {
            case .story(let id):
                return try getStory(forID: id)
            }
        }
        catch (let error) {
            throw error
        }
    }
    
}

extension StoryRequestProvider {
    func getStory(forID id: Int) throws -> URLRequest {
        let endPoint = "https://hacker-news.firebaseio.com/v0/item/\(id).json"
        guard let url = URL(string: endPoint) else {
            throw ApiError.badURL
        }
        do {
            let request = try URLRequest(url: url, method: .get, headers: nil) //pass the key in headers
            return request
        } catch {
            throw ApiError.badURL
        }
    }
}
