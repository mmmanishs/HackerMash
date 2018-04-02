//
//  HelperFuncs.swift
//  HackerMash
//
//  Created by Manish Singh on 3/28/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit

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


func merge<T>(array1: [T], array2: [T]) -> [T] where T: Comparable{
    guard array1.count > 0 else {
        return array2
    }
    guard array2.count > 0 else {
        return array1
    }
    
    var finalArray = array1
    for element in array2 {
        if let index = finalArray.index(of: element) {
            finalArray[index] = element
        } else {
            finalArray.append(element)
        }
    }
    return finalArray
}

func getRandomColor() -> UIColor {
    let colorArray = [UIColor.flatRed, UIColor.flatPurple ,UIColor.flatPurpleDark, UIColor.flatPlum ,UIColor.flatGreen, UIColor.flatPinkDark, UIColor.flatGrayDark, UIColor.flatMaroon, UIColor.flatRedDark]
    let i: Int = Int(arc4random_uniform(UInt32(colorArray.count)))
    return colorArray[i]
}
