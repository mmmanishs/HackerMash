//
//  HelperFuncs.swift
//  HackerMash
//
//  Created by Manish Singh on 3/28/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

func merge<T>(old: inout [T], new: [T]) where T: Comparable{
    guard old.count > 0 else {
        old = new
        return
    }
    for element in new {
        if let index = old.index(of: element) {
            old[index] = element
        } else {
            old.append(element)
        }
    }
}
