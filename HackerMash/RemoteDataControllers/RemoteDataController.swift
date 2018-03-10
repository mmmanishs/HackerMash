//
//  RemoteDataController.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
import Alamofire

class RemoteDataController {
    func getStoriesID(url: URLRequest) -> Promise<StoryIDs> {
        let promise = Promise<StoryIDs>(on:.global()) { fullfil, reject in
            let remote = Alamofire.request(url)
            remote.responseData() { response in
                guard let data = response.result.value else {
                    reject(ApiError.dataReturnedIsNull)
                    return
                }
                let decoder = JSONDecoder()
                do { //Parsing now
                    let decodedData = try decoder.decode([Int].self, from: data) as [Int]
                    fullfil(StoryIDs(ids: decodedData))
                } catch (let error){
                    reject(error)
                }
            }
        }
        return promise
    }
    
    func getStory(url: URLRequest) -> Promise<Story> {
        let promise = Promise<Story>(on:.global()) { fullfil, reject in
            let remote = Alamofire.request(url)
            remote.responseData() { response in
                guard let data = response.result.value else {
                    reject(ApiError.dataReturnedIsNull)
                    return
                }
                let decoder = JSONDecoder()
                do { //Parsing now
                    let decodedData = try decoder.decode(Story.self, from: data) as Story
                    fullfil(decodedData)
                    
                } catch (let error){
                    reject(error)
                }
            }
        }
        return promise
    }
}


