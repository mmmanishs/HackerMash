//
//  StoryIDsRequestProvider.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

protocol RequestProvider {
    func getRequest() throws -> URLRequest
}
enum StoryIDsRequestProvider: RequestProvider {
    case topStories
    case logo(String)
    func getRequest() throws -> URLRequest {
        do {
            switch self {
            case .topStories:
                return try getTopStoriesRequest()
                
            case .logo(let domainName):
                return try getNewsLogoRequest(domainName: domainName)
                
            }
        }
        catch (let error) {
            throw error
        }
    }

    private func getTopStoriesRequest() throws -> URLRequest {
        let endPoint = "https://hacker-news.firebaseio.com/v0/topstories.json"
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
    
    private func getNewsLogoRequest(domainName: String) throws -> URLRequest {
        let endPoint = "https://logo.clearbit.com/\(domainName)"
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

extension RequestProvider {
    static func getLogoUrl(domainName: String) -> URL? {
        let endPoint = "https://logo.clearbit.com/\(domainName)"
        guard let url = URL(string: endPoint) else {
            return nil
        }
        return url
    }
}
