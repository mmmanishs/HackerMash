//
//  LocalData.swift
//  HackerMash
//
//  Created by Manish Singh on 3/10/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Default

class LocalDataManager {
    var localData: LocalData
    
    init() {
        if let localData = LocalData.read(forKey: "localData") {
            self.localData = localData
        } else {
            localData = LocalData(readIds: [])
            localData.write(withKey: "localData")
        }
    }
    
    func writeIDAsRead(id: Int){
        localData.readIds.append(id)         
        localData.write(withKey: "localData")
    }
    
    func isIDMarkedAsRead(id: Int) -> Bool {
        return localData.readIds.contains(id)
    }
}


struct LocalData: Codable, DefaultStorable {
    var readIds: [Int]
}


