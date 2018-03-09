//
//  Result.swift
//  HackerMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ApiError: Error {
    case badURL
    case apiError
    case dataReturnedIsNull
    case malformedData
}
